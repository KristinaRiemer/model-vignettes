Getting Setaria Biomass Coefficients from BioCro v1.0
================
Author: Kristina Riemer

### Switching between BioCro versions locally

Needs to be run using BioCro version 1.0. Check your BioCro version:

``` r
library(BioCro)
if(!packageVersion(pkg = 'BioCro') <= 1.0){
  warning("need to use BioCro v1.0 or greater")
} else {
  devtools::install_github('ebimodeling/biocro@new-framework')  
}
```

### Read in data

These two dataframes include hourly weather data for a year that match the conditions the *Setaria* plants were grown in, and measured biomass values for plants at six harvest dates.

The first dataframe is weather data simulated based on growth chamber settings (this was created in the file `biocro_biomass_darpa.Rmd`).

The second dataframe is some biomass measurements that will be used to calibrate the BioCro biomass partitioning parameters.

``` r
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
opt_weather <- read.csv("opt_inputs/opt_weather.csv") %>% 
  rename(solar = solarR, temp = Temp, rh = RH, windspeed = WS)
opt_biomass <- read.csv("opt_inputs/opt_biomass.csv")
```

### Set up parameters

The following code uses BioCro 1.0.

Set up the parameters for *Setaria* using these two lists, `setaria_initial_state` and `setaria_parameters`. This uses parameter values from optimizing the older version of BioCro.

``` r
load("biomass_coeffs_1.0_inputs/setaria_initial_state.Rmd")
load("biomass_coeffs_1.0_inputs/setaria_parameters.Rmd")
```

Create the modules, which are currently developed for *Sorghum*.

``` r
 setaria_modules <- list(
  canopy_module_name               = 'c4_canopy',
  soil_module_name                 = 'one_layer_soil_profile',
  growth_module_name               = 'partitioning_growth',
  senescence_module_name           = 'thermal_time_senescence',
  leaf_water_stress_module_name    = 'leaf_water_stress_exponential',
  stomata_water_stress_module_name = 'stomata_water_stress_linear')
```

### Optimizing `Gro` for *Setaria* parameters

This next step fits the BioCro biomass coefficients to the observed time series of biomass in different pools (stem, leaf, root, grain). Once we have fit these parameters, we can add them to the `setaria_parameters` and use them in future simulations. Parameters that are optimized are the leaf, stem, root, and grain coefficients (e.g., `kStem1`). Since setaria doesn't have a rhizome, these parameters are fixed at zero.

The optimization returns these values for biomass growth by plant part and stage where the difference between measured and estimated biomass values is minimized. We optimized across all six stages simultaneously.

### Set up and test objective function

First the objective function `opfn` is created, which has its only argument as the parameters to be optimized over, called `k_params`.

The function is tested with example parameters, which are all set to 0.2.

``` r
k_params_index <- c(53:55, 58:60, 63:65, 68:70, 73:75, 78:80, 82)
nonk_params <- setaria_parameters[-k_params_index]

opfn <- function(k_params){
  k_params_names   <- names(setaria_parameters[k_params_index])
  length(k_params) <- length(k_params_names)
  k_params_vec     <- unlist(k_params)
  k_params[1:3]    <- as.list(k_params_vec[1:3]/sum(k_params_vec[1:3]))
  k_params_vec     <- unlist(k_params)
  k_params[4:6]    <- as.list(k_params_vec[4:6]/sum(k_params_vec[4:6]))
  k_params_vec     <- unlist(k_params)
  k_params[7:9]    <- as.list(k_params_vec[7:9]/sum(k_params_vec[7:9]))
  k_params_vec     <- unlist(k_params)
  k_params[10:12]  <- as.list(k_params_vec[10:12]/sum(k_params_vec[10:12]))
  k_params_vec     <- unlist(k_params)
  k_params[13:15]  <- as.list(k_params_vec[13:15]/sum(k_params_vec[13:15]))
  k_params_vec     <- unlist(k_params)
  k_params[16:19]  <- as.list(k_params_vec[16:19]/sum(k_params_vec[16:19]))
  all_params       <- c(nonk_params, k_params)
  names(all_params)[88:106] <- k_params_names
  t <- Gro(setaria_initial_state,
           all_params,
           get_growing_season_climate(opt_weather),
           setaria_modules)
  tt <- t %>%
    select(TTc, Stem, Leaf, Root, Rhizome, Grain) %>%
    rename(ThermalT = TTc)
  ttt <- tt %>%
    filter(round(tt$ThermalT) %in% round(opt_biomass$ThermalT))
  bio_ests <- select(ttt, -ThermalT)
  bio_meas <- select(opt_biomass, -ThermalT, -LAI)
  diff <- abs(log10(bio_ests + 1) - log10(bio_meas + 1))
  return(sum(diff))
}

k_params_ex <- setaria_parameters[k_params_index]

for(i in 1:length(k_params_ex)){
  k_params_ex[[i]] <- 0.2
}
opfn(k_params_ex)
```

    ## [1] 1.747332

### Run optimization and plot

The objective function is run through optimization with `DEoptim`, with upper and lower bounds for the parameters set to 0 and 1. The `itermax` value is set low enough for this to complete in a few minutes, though the difference is increasingly minimized with more iterations.

``` r
k_params <- setaria_parameters[k_params_index]
lower <- unlist(k_params)-0.2
lower[lower < 0] <- 0
upper <- unlist(k_params) + 0.2
upper[upper > 1] <- 1

library(DEoptim)
```

    ## Loading required package: parallel

    ## 
    ## DEoptim package
    ## Differential Evolution algorithm in R
    ## Authors: D. Ardia, K. Mullen, B. Peterson and J. Ulrich

``` r
opt_results <- DEoptim(
  fn = opfn, 
  lower = lower, 
  upper = upper,
  DEoptim.control(NP = 190, itermax = 10,
                  parallelType = 1, 
                  packages = list("BioCro", "dplyr"),
                  parVar = list('setaria_parameters', 
                                'k_params_index', 
                                'k_params', 'nonk_params', 
                                'setaria_modules', 
                                'opt_weather',
                                'setaria_initial_state',
                                'opt_biomass'))
)
```

    ## Iteration: 1 bestvalit: 1.705860 bestmemit:    0.260523    0.548657    0.205178    0.233021    0.479167    0.296545    0.255868    0.706306    0.039562    0.581224    0.514066    0.075248    0.744871    0.304740    0.217555    0.747726    0.138765    0.109643    0.260618
    ## Iteration: 2 bestvalit: 1.698546 bestmemit:    0.149361    0.548657    0.205178    0.233021    0.479167    0.296545    0.255868    0.706306    0.039562    0.581224    0.514066    0.075248    0.744871    0.304740    0.217555    0.747726    0.138765    0.109643    0.260618
    ## Iteration: 3 bestvalit: 1.698546 bestmemit:    0.149361    0.548657    0.205178    0.233021    0.479167    0.296545    0.255868    0.706306    0.039562    0.581224    0.514066    0.075248    0.744871    0.304740    0.217555    0.747726    0.138765    0.109643    0.260618
    ## Iteration: 4 bestvalit: 1.698065 bestmemit:    0.149361    0.548657    0.205178    0.221056    0.479167    0.296545    0.255868    0.706306    0.039562    0.581224    0.514066    0.075248    0.744871    0.304740    0.217555    0.747726    0.138765    0.109643    0.260618
    ## Iteration: 5 bestvalit: 1.692119 bestmemit:    0.146438    0.533271    0.202569    0.197248    0.572025    0.286245    0.313718    0.599563    0.067131    0.360794    0.399032    0.041271    0.669435    0.304343    0.170623    0.935276    0.086740    0.185670    0.066174
    ## Iteration: 6 bestvalit: 1.692119 bestmemit:    0.146438    0.533271    0.202569    0.197248    0.572025    0.286245    0.313718    0.599563    0.067131    0.360794    0.399032    0.041271    0.669435    0.304343    0.170623    0.935276    0.086740    0.185670    0.066174
    ## Iteration: 7 bestvalit: 1.691914 bestmemit:    0.146438    0.533271    0.202569    0.197248    0.572025    0.286245    0.313718    0.599563    0.067131    0.360794    0.399032    0.041271    0.669435    0.304343    0.170623    0.881852    0.196625    0.185670    0.066174
    ## Iteration: 8 bestvalit: 1.691031 bestmemit:    0.146438    0.533271    0.202569    0.197248    0.572025    0.286245    0.313718    0.599563    0.067131    0.360794    0.399032    0.041271    0.669435    0.304343    0.170623    0.881852    0.196625    0.185670    0.022404
    ## Iteration: 9 bestvalit: 1.682705 bestmemit:    0.149597    0.490932    0.189918    0.262931    0.565121    0.193862    0.250143    0.697928    0.073533    0.295805    0.578536    0.184532    0.557035    0.373467    0.072216    0.596641    0.135659    0.258629    0.037899
    ## Iteration: 10 bestvalit: 1.682420 bestmemit:    0.149597    0.490932    0.189918    0.262931    0.565121    0.193862    0.250143    0.697928    0.073533    0.295805    0.578536    0.184532    0.557035    0.373467    0.072216    0.596641    0.139436    0.090957    0.037899

The resulting optimized parameters are put through the model again.

``` r
optimal_k_params <- as.list(opt_results$optim$bestmem)
names(optimal_k_params) <- names(setaria_parameters[k_params_index])

opt_vec <- unlist(optimal_k_params)
optimal_k_params[1:3] <- as.list(opt_vec[1:3]/sum(opt_vec[1:3]))
opt_vec <- unlist(optimal_k_params)
optimal_k_params[4:6] <- as.list(opt_vec[4:6]/sum(opt_vec[4:6]))
opt_vec <- unlist(optimal_k_params)
optimal_k_params[7:9] <- as.list(opt_vec[7:9]/sum(opt_vec[7:9]))
opt_vec <- unlist(optimal_k_params)
optimal_k_params[10:12] <- as.list(opt_vec[10:12]/sum(opt_vec[10:12]))
opt_vec <- unlist(optimal_k_params)
optimal_k_params[13:15] <- as.list(opt_vec[13:15]/sum(opt_vec[13:15]))
opt_vec <- unlist(optimal_k_params)
optimal_k_params[16:19] <- as.list(opt_vec[16:19]/sum(opt_vec[16:19]))

optimal_params <- c(nonk_params, optimal_k_params)

biomass_opt_parms <- Gro(setaria_initial_state, 
                         optimal_params,
                         get_growing_season_climate(opt_weather),
                         setaria_modules)
```

The resulting biomass estimates are plotted agaist the measured values.

``` r
library(ggplot2)
plot_biomass <- function(biomass_estimates){
  est_plot <- biomass_estimates %>% 
    select(TTc, Stem, Leaf, Root, Rhizome, Grain) %>% 
    tidyr::pivot_longer(Stem:Grain) %>% 
    rename(ThermalT = TTc)
  data_plot <- opt_biomass %>% 
    select(-LAI) %>% 
    tidyr::pivot_longer(Stem:Grain)
  biomass_plot <- ggplot() +
    geom_point(data_plot, mapping = aes(x = ThermalT, y = value, color = name)) +
    geom_line(est_plot, mapping = aes(x = ThermalT, y = value, color = name)) + 
    lims(x = c(0, 1800), y = c(0, 2)) +
    labs(x = "Thermal Time", y = "Biomass (Ma/ha)", color = "Plant Part") + 
    theme_classic() +
    theme(legend.position = "none") +
    facet_wrap(~name)
  print(biomass_plot)
}

plot_biomass(biomass_opt_parms)
```

    ## Warning: Removed 21950 rows containing missing values (geom_path).

![](biomass_coeffs_1.0_files/figure-markdown_github/unnamed-chunk-8-1.png)
