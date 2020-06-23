Using BioCro 1.0 on Setaria Data
================
Author: Kristina Riemer

### Switching between BioCro versions locally

Needs to be run using BioCro version 1.0. Check your BioCro version:

``` r
library(BioCro)
sessionInfo()
```

    ## R version 3.6.1 (2019-07-05)
    ## Platform: x86_64-apple-darwin15.6.0 (64-bit)
    ## Running under: macOS Catalina 10.15.4
    ## 
    ## Matrix products: default
    ## BLAS:   /Library/Frameworks/R.framework/Versions/3.6/Resources/lib/libRblas.0.dylib
    ## LAPACK: /Library/Frameworks/R.framework/Versions/3.6/Resources/lib/libRlapack.dylib
    ## 
    ## locale:
    ## [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## other attached packages:
    ## [1] BioCro_1.00
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] compiler_3.6.1  magrittr_1.5    tools_3.6.1     htmltools_0.4.0
    ##  [5] yaml_2.2.1      Rcpp_1.0.4      stringi_1.4.6   rmarkdown_2.1  
    ##  [9] grid_3.6.1      knitr_1.28      stringr_1.4.0   xfun_0.12      
    ## [13] digest_0.6.25   rlang_0.4.5     lattice_0.20-38 evaluate_0.14

Download repos for [BioCro 0.95](https://github.com/ebimodeling/biocro)
and
[BioCro 1.0](https://github.com/ebimodeling/biocro/tree/new-framework),
and place unzipped folders into this repo in `BioCro/DARPA`. Use the
code below to switch between these two versions when needs.

BioCro
0.95:

``` r
install.packages('biocro_0.95/biocro-master', repos = NULL, type = 'SOURCE')
```

BioCro
1.0:

``` r
install.packages('biocro_1.00/biocro-new-framework', repos = NULL, type = 'SOURCE')
```

Check version:

``` r
library(BioCro)
sessionInfo()
```

    ## R version 3.6.1 (2019-07-05)
    ## Platform: x86_64-apple-darwin15.6.0 (64-bit)
    ## Running under: macOS Catalina 10.15.4
    ## 
    ## Matrix products: default
    ## BLAS:   /Library/Frameworks/R.framework/Versions/3.6/Resources/lib/libRblas.0.dylib
    ## LAPACK: /Library/Frameworks/R.framework/Versions/3.6/Resources/lib/libRlapack.dylib
    ## 
    ## locale:
    ## [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## other attached packages:
    ## [1] BioCro_1.00
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] compiler_3.6.1  magrittr_1.5    tools_3.6.1     htmltools_0.4.0
    ##  [5] yaml_2.2.1      Rcpp_1.0.4      stringi_1.4.6   rmarkdown_2.1  
    ##  [9] grid_3.6.1      knitr_1.28      stringr_1.4.0   xfun_0.12      
    ## [13] digest_0.6.25   rlang_0.4.5     lattice_0.20-38 evaluate_0.14

### Read in data

These two dataframes include hourly weather data for a year that match
the conditions the *Setaria* plants were grown in, and measured biomass
values for plants at six harvest dates. The former will be used to run
the model and the latter to tune the model parameters.

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
OpBioGro_weather <- read.csv("biocro_opt_darpa_files/OpBioGro_weather.csv") %>% 
  rename(solar = solarR, temp = DailyTemp.C, rh = RH, windspeed = WindSpeed)
OpBioGro_biomass <- read.csv("biocro_opt_darpa_files/OpBioGro_biomass.csv")
```

### Set up parameters

The following code uses BioCro 1.0.

Set up the parameters for *Setaria* using these two lists,
`setaria_initial_state` and `setaria_parameters`. This uses parameter
values from optimizing the older version of BioCro.

``` r
setaria_initial_state <- with(list(), {
  datalines =
    "symbol value
    
    # BioCro arguments
    Rhizome 0.001
    Leaf 0.001
    Stem 0.001
    Root 0.001
    
    Grain 0
    soil_water_content 0.32
    LeafN 2
    TTc 0
    LeafLitter 0
    RootLitter 0
    RhizomeLitter 0
    StemLitter 0
    leaf_senescence_index 0
    stem_senescence_index 0
    root_senescence_index 0
    rhizome_senescence_index 0"
  
  data_frame = utils::read.table(textConnection(datalines), header=TRUE)
  values = as.list(data_frame$value)
  names(values) = data_frame$symbol
  values
})

setaria_parameters <- with(list(), {
  datalines =
    "symbol value
    acceleration_from_gravity 9.8
    
    # config$location$latitude
    lat 38.67459
    
    soil_clod_size 0.04
    soil_reflectance 0.2
    soil_transmission 0.01
    specific_heat 1010
    stefan_boltzman 5.67e-8
    iSp 1.7
    Sp_thermal_time_decay 0
    
    # canopyControl
    nlayers 10
    kd 0.1
    chil 1
    heightf 3
    leafwidth 0.04
    et_equation 0
    
    growth_respiration_fraction 0 # is this mResp?
    
    # seneControl
    seneLeaf 3000
    seneStem 3500
    seneRoot 4000
    seneRhizome 4000
    
    tbase 0
    
    # photoParms
    vmax1 29.7409235442261
    alpha1 0.04
    kparm 0.7
    theta 0.83
    beta 0.93
    Rd 1.33025819997024
    Catm 400
    b0 0.0138148692577794
    b1 5.7057446269736
    water_stress_approach 1
    upperT 37.5
    lowerT 3

    # soil control (only missing FieldC & WiltP)
    phi1 0.01
    phi2 10
    soil_depth 1
    soil_type_indicator 6
    soilLayers 1
    wsFun 0
    scsf 1
    transpRes 5000000
    leafPotTh -800
    hydrDist 0
    rfl 0.2
    rsec 0.2
    rsdf 0.44
    
    # optimalParms
    tp1 150
    tp2 300
    tp3 450
    tp4 600
    tp5 750
    tp6 900
    kStem1 0.312482562
    kLeaf1 0.350204711
    kRoot1 0.337312727
    kRhizome1 0
    kGrain1 0
    kStem2 0.28215246
    kLeaf2 0.385131018
    kRoot2 0.332716522
    kRhizome2 0
    kGrain2 0
    kStem3 0.449611092
    kLeaf3 0.549167954
    kRoot3 0.001220954
    kRhizome3 0
    kGrain3 0
    kStem4 0.450730685
    kLeaf4 0.38210712
    kRoot4 0.167162195
    kRhizome4 0
    kGrain4 0
    kStem5 0.687613079
    kLeaf5 0.197814203
    kRoot5 0.114572719
    kRhizome5 0
    kGrain5 0
    kStem6 0.758825523
    kLeaf6 0.01127437
    kRoot6 0.143217809
    kRhizome6 0
    kGrain6 0.086682298
    
    LeafN_0 2
    kln 0.5
    vmax_n_intercept 0
    alphab1 0
    kpLN 0.2
    lnb0 -5
    lnb1 18
    lnfun 0
    nileafn 85
    nkln 0.5
    nvmaxb1 0.6938
    nvmaxb0 -16.25
    nalphab1 0.000488
    nalphab0 0.02367
    nRdb1 0.1247
    nRdb0 -4.5917
    nkpLN 0.17
    nlnb0 -5
    nlnb1 18
    timestep 1
    mrc1 0.02
    mrc2 0.03
    leaf_reflectance 0.2
    leaf_transmittance 0.2"
  
  data_frame = utils::read.table(textConnection(datalines), header=TRUE)
  values = as.list(data_frame$value)
  names(values) = data_frame$symbol
  values
})
```

Create the modules, which are currently developed for *Sorghum*.

``` r
setaria_modules <- list(canopy_module_name='c4_canopy',
                       soil_module_name='one_layer_soil_profile',
                       growth_module_name='partitioning_growth',
                       senescence_module_name='thermal_time_senescence',
                       leaf_water_stress_module_name='leaf_water_stress_exponential',
                       stomata_water_stress_module_name='stomata_water_stress_linear')
```

### Run model

Use these three inputs, along with the weather data, to generate biomass
values for **Setaria** using BioCro function `Gro`.

### Optimizing `Gro` for *Setaria* parameters

This optimizes the biomass coefficients so that BioCro biomass estimates
better match the measured values. Parameters that are optimized are the
leaf, stem, root, and grain coefficients (e.g., `kStem1`), not including
the value for the sixth rhizome stage (`kRhizome6`), which must be zero.

The optimization returns these values for biomass growth by plant part
and stage where the difference between measured and estimated biomass
values is minimized. We optimized across all six stages simultaneously.

### Set up and test objective function

First the objective function `opfn` is created, which has its only
argument as the parameters to be optimized over, called `k_params`.

The function is tested with example parameters, which are all set to
0.2.

``` r
k_params_index <- c(53:55, 58:60, 63:65, 68:70, 73:75, 78:80, 82)
nonk_params <- setaria_parameters[-k_params_index]

opfn <- function(k_params){
  k_params_names <- names(setaria_parameters[k_params_index])
  length(k_params) <- length(k_params_names)
  k_params_vec <- unlist(k_params)
  k_params[1:3] <- as.list(k_params_vec[1:3]/sum(k_params_vec[1:3]))
  k_params_vec <- unlist(k_params)
  k_params[4:6] <- as.list(k_params_vec[4:6]/sum(k_params_vec[4:6]))
  k_params_vec <- unlist(k_params)
  k_params[7:9] <- as.list(k_params_vec[7:9]/sum(k_params_vec[7:9]))
  k_params_vec <- unlist(k_params)
  k_params[10:12] <- as.list(k_params_vec[10:12]/sum(k_params_vec[10:12]))
  k_params_vec <- unlist(k_params)
  k_params[13:15] <- as.list(k_params_vec[13:15]/sum(k_params_vec[13:15]))
  k_params_vec <- unlist(k_params)
  k_params[16:19] <- as.list(k_params_vec[16:19]/sum(k_params_vec[16:19]))
  all_params <- c(nonk_params, k_params)
  names(all_params)[88:106] <- k_params_names
  t <- Gro(setaria_initial_state,
           all_params,
           get_growing_season_climate(OpBioGro_weather),
           setaria_modules)
  tt <- t %>%
    select(TTc, Stem, Leaf, Root, Rhizome, Grain) %>%
    rename(ThermalT = TTc)
  ttt <- tt %>%
    filter(round(tt$ThermalT) %in% round(OpBioGro_biomass$ThermalT))
  bio_ests <- select(ttt, -ThermalT)
  bio_meas <- select(OpBioGro_biomass, -ThermalT, -LAI)
  diff <- abs(bio_ests - bio_meas)
  return(sum(diff))
}

k_params_ex <- setaria_parameters[k_params_index]
for(i in 1:length(k_params_ex)){
  k_params_ex[[i]] <- 0.2
}
opfn(k_params_ex)
```

    ## [1] 5.511087

### Run optimization and plot

The objective function is run through optimization with `DEoptim`, with
upper and lower bounds for the parameters set to 0 and 1. The `itermax`
value is set low enough for this to complete in a few minutes, though
the difference is increasingly minimized with more iterations.

``` r
library(DEoptim)
```

    ## Loading required package: parallel

    ## 
    ## DEoptim package
    ## Differential Evolution algorithm in R
    ## Authors: D. Ardia, K. Mullen, B. Peterson and J. Ulrich

``` r
opt_results <- DEoptim(fn = opfn, lower = rep(0, 19), upper = rep(1, 19), control = DEoptim.control(itermax = 2))
```

    ## Iteration: 1 bestvalit: 5.213012 bestmemit:    0.035186    0.236113    0.191350    0.143494    0.809243    0.049690    0.394099    0.535299    0.073443    0.046050    0.749915    0.265888    0.639519    0.350709    0.494354    0.962520    0.702855    0.123164    0.761511
    ## Iteration: 2 bestvalit: 5.178262 bestmemit:    0.060361    0.832525    0.208351    0.363691    0.767208    0.206144    0.218434    0.718856    0.150816    0.603654    0.986502    0.841803    0.677864    0.543521    0.179073    0.993378    0.542835    0.414788    0.610184

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
                         get_growing_season_climate(OpBioGro_weather),
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
  data_plot <- OpBioGro_biomass %>% 
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

![](biocro_1.0_darpa_files/figure-gfm/unnamed-chunk-11-1.png)<!-- -->