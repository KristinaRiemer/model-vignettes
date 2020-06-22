How to Reproduce BioCro Results for Night Time Temperature Experiments
================
Kristina Riemer, University of Arizona

For these experiments, **Setaria** were grown under two experimental
treatments. The control plants were at 31\(^\circ\)C during the day and
22\(^\circ\)C at night, while high night time temp treatment was
31\(^\circ\)C at all times.

Biomass for these two treatments are estimated using BioCro version
0.95.

# Section 1: BioCro Run for Control Parameters & Weather

1.  Access RStudio in a browser by navigating to
    <welsch.cyverse.org:8787/>. Log in using your username and password.

2.  Create a new folder called `biocro_temp_exps_files1`.

3.  Create new XML called `pecan.biocro.darpa.temp.exps1.xml`

<!-- end list -->

``` r
<pecan>
  <outdir>biocro_temp_exps_results1</outdir>

  <database>
    <bety>
      <driver>PostgreSQL</driver>
      <user>bety</user>
      <password>bety</password>
      <host>postgres</host>
      <dbname>bety</dbname>
      <write>FALSE</write>
    </bety>
    <dbfiles>biocro_temp_exps_results1/dbfiles</dbfiles>
  </database>

  <pfts>
    <pft>
      <name>SetariaWT_ME034</name>
      <constants>
        <file>biocro_temp_exps_files1/setaria.constants.xml</file>
      </constants>
    </pft>
  </pfts>

  <ensemble>
    <size>10</size>
    <variable>TotLivBiom</variable>
  </ensemble>

  <meta.analysis>
    <iter>3000</iter>
    <random.effects>TRUE</random.effects>
    <threshold>1.2</threshold>
    <update>AUTO</update>
  </meta.analysis>

  <sensitivity.analysis>
    <variable>TotLivBiom</variable>
  </sensitivity.analysis>

  <model>
    <type>BIOCRO</type>
    <binary>/home/kristinariemer/pecan/models/biocro/inst/biocro.Rscript</binary>
    <revision>0.95</revision>
  </model>

  <run>
    <site>
      <id>9000000004</id>
    </site>
    <inputs>
      <met>
        <output>BIOCRO</output>
        <path>/home/kristinariemer/biocro_temp_exps_files1/danforth-control-chamber</path>
      </met>
    </inputs>
      <start.date>2019/01/01</start.date>
      <end.date>2019/12/30</end.date>
    <host>
      <name>localhost</name>
    </host>
  </run>
</pecan>
```

4.  Create Setaria constants file `setaria.constants.xml`. This has
    biomass coefficients and starting biomass values. The same will be
    used for all runs.

<!-- end list -->

``` r
<constants>
  <type>
    <photosynthesis>C4</photosynthesis>
    <genus>Setaria</genus>
  </type>
  <canopyControl>
    <Sp>1.7</Sp>
    <SpD>0</SpD>
    <nlayers>10</nlayers>
    <kd>0.1</kd>
    <chi.l>1</chi.l>
    <mResp>0.02,0.03</mResp>
    <heightFactor>3</heightFactor>
    <leafwidth>0.04</leafwidth>
    <eteq>0</eteq>
  </canopyControl>
  <iPlantControl>
    <iRhizome>0.001</iRhizome>
    <iStem>0.001</iStem>
    <iLeaf>0.001</iLeaf>
    <iRoot>0.001</iRoot>
    <ifrRhizome>0.01</ifrRhizome>
    <ifrStem>0.01</ifrStem> 
  </iPlantControl>
  <photoParms>
    <vmax>39</vmax>
    <alpha>0.04</alpha>
    <kparm>0.7</kparm>
    <theta>0.83</theta>
    <beta>0.93</beta>
    <Rd>0.8</Rd>
    <Catm>500</Catm>
    <b0>0.01</b0>
    <b1>3</b1>
    <ws>1</ws>
    <UPPERTEMP>37.5</UPPERTEMP>
    <LOWERTEMP>3</LOWERTEMP>
  </photoParms>
  <phenoControl>
    <Tbase>0</Tbase>
  </phenoControl>
  <seneControl>
    <senLeaf>3000</senLeaf>
    <senStem>3500</senStem>
    <senRoot>4000</senRoot>
    <senRhizome>4000</senRhizome>
  </seneControl>
  <soilControl>
    <FieldC>-1</FieldC>
    <WiltP>-1</WiltP>
    <phi1>0.01</phi1>
    <phi2>10</phi2>
    <soilDepth>1</soilDepth>
    <iWatCont>0.32</iWatCont>
    <soilType>6</soilType>
    <soilLayers>1</soilLayers>
    <soilDepths/>
    <wsFun>0</wsFun>
    <scsf>1</scsf>
    <transpRes>5000000</transpRes>
    <leafPotTh>-800</leafPotTh>
    <hydrDist>0</hydrDist>
    <rfl>0.2</rfl>
    <rsec>0.2</rsec>
    <rsdf>0.44</rsdf>
  </soilControl>
  <phenoParms>
    <tp1>150</tp1>
    <tp2>300</tp2>
    <tp3>450</tp3>
    <tp4>600</tp4>
    <tp5>750</tp5>
    <tp6>900</tp6>
    <kStem1>0.07797131</kStem1>
    <kLeaf1>0.4574688</kLeaf1>
    <kRoot1>0.4645599</kRoot1>
    <kRhizome1>0.00000001</kRhizome1>
    <kStem2>0.3682341</kStem2>
    <kLeaf2>0.3520679</kLeaf2>
    <kRoot2>0.279698</kRoot2>
    <kRhizome2>0.00000001</kRhizome2>
    <kStem3>0.2998348</kStem3>
    <kLeaf3>0.6848535</kLeaf3>
    <kRoot3>0.01531178</kRoot3>
    <kRhizome3>0.00000001</kRhizome3>
    <kStem4>0.669772</kStem4>
    <kLeaf4>0.2855325</kLeaf4>
    <kRoot4>0.04469549</kRoot4>
    <kRhizome4>0.00000001</kRhizome4>
    <kStem5>0.1630056</kStem5>
    <kLeaf5>0.8037141</kLeaf5>
    <kRoot5>0.0332803</kRoot5>
    <kRhizome5>0.00000001</kRhizome5>
    <kStem6>0.7787245</kStem6>
    <kLeaf6>0.02861919</kLeaf6>
    <kRoot6>0.1399813</kRoot6>
    <kRhizome6>0.00000001</kRhizome6>
    <kGrain6>0.05267502</kGrain6>
  </phenoParms>
</constants>
```

5.  Create new `workflow.R`

<!-- end list -->

``` r
#!/usr/bin/env Rscript
#-------------------------------------------------------------------------------
# Copyright (c) 2012 University of Illinois, NCSA.
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the 
# University of Illinois/NCSA Open Source License
# which accompanies this distribution, and is available at
# http://opensource.ncsa.illinois.edu/license.html
#-------------------------------------------------------------------------------

# ----------------------------------------------------------------------
# Load required libraries
# ----------------------------------------------------------------------
library(PEcAn.all)
library(PEcAn.utils)
library(RCurl)

# make sure always to call status.end
options(warn=1)
options(error=quote({
  PEcAn.utils::status.end("ERROR")
  PEcAn.remote::kill.tunnel(settings)
  if (!interactive()) {
    q(status = 1)
  }
}))

#options(warning.expression=status.end("ERROR"))


# ----------------------------------------------------------------------
# PEcAn Workflow
# ----------------------------------------------------------------------
# Open and read in settings file for PEcAn run.
args <- commandArgs(trailingOnly = TRUE)
if (is.na(args[1])){
  settings <- PEcAn.settings::read.settings("pecan.xml") 
} else {
  settings.file <- args[1]
  settings <- PEcAn.settings::read.settings(settings.file)
}

# Check for additional modules that will require adding settings
if("benchmarking" %in% names(settings)){
  library(PEcAn.benchmark)
  settings <- papply(settings, read_settings_BRR)
}

if("sitegroup" %in% names(settings)){
  if(is.null(settings$sitegroup$nSite)){
    settings <- PEcAn.settings::createSitegroupMultiSettings(settings, 
                                                             sitegroupId = settings$sitegroup$id)
  } else {
    settings <- PEcAn.settings::createSitegroupMultiSettings(settings, 
                                                             sitegroupId = settings$sitegroup$id,
                                                             nSite = settings$sitegroup$nSite)
  }
  settings$sitegroup <- NULL ## zero out so don't expand a second time if re-reading
}

# Update/fix/check settings. Will only run the first time it's called, unless force=TRUE
settings <- PEcAn.settings::prepare.settings(settings, force = FALSE)

# Write pecan.CHECKED.xml
PEcAn.settings::write.settings(settings, outputfile = "pecan.CHECKED.xml")

# start from scratch if no continue is passed in
statusFile <- file.path(settings$outdir, "STATUS")
if (length(which(commandArgs() == "--continue")) == 0 && file.exists(statusFile)) {
  file.remove(statusFile)
}

# Do conversions
settings <- PEcAn.workflow::do_conversions(settings)

# Query the trait database for data and priors
if (PEcAn.utils::status.check("TRAIT") == 0){
  PEcAn.utils::status.start("TRAIT")
  settings <- PEcAn.workflow::runModule.get.trait.data(settings)
  PEcAn.settings::write.settings(settings, outputfile='pecan.TRAIT.xml')
  PEcAn.utils::status.end()
} else if (file.exists(file.path(settings$outdir, 'pecan.TRAIT.xml'))) {
  settings <- PEcAn.settings::read.settings(file.path(settings$outdir, 'pecan.TRAIT.xml'))
}

library(dplyr)
trait <- read.csv("biocro_temp_exps_results1/pft/SetariaWT_ME034/trait.data.csv") %>%
  filter(mean < 25)
write.csv(trait, "biocro_temp_exps_results1/pft/SetariaWT_ME034/trait.data.csv")

load("biocro_temp_exps_results1/pft/SetariaWT_ME034/trait.data.Rdata")
file.remove("biocro_temp_exps_results1/pft/SetariaWT_ME034/trait.data.Rdata")
trait.data$Vcmax <- trait.data$Vcmax[4:15,]
save(trait.data, file = "/home/kristinariemer/biocro_temp_exps_results1/pft/SetariaWT_ME034/trait.data.Rdata")

# Run the PEcAn meta.analysis
if(!is.null(settings$meta.analysis)) {
  if (PEcAn.utils::status.check("META") == 0){
    PEcAn.utils::status.start("META")
    PEcAn.MA::runModule.run.meta.analysis(settings)
    PEcAn.utils::status.end()
  }
}

# Write model specific configs
if (PEcAn.utils::status.check("CONFIG") == 0){
  PEcAn.utils::status.start("CONFIG")
  settings <- PEcAn.workflow::runModule.run.write.configs(settings)
  PEcAn.settings::write.settings(settings, outputfile='pecan.CONFIGS.xml')
  PEcAn.utils::status.end()
} else if (file.exists(file.path(settings$outdir, 'pecan.CONFIGS.xml'))) {
  settings <- PEcAn.settings::read.settings(file.path(settings$outdir, 'pecan.CONFIGS.xml'))
}

if ((length(which(commandArgs() == "--advanced")) != 0) && 
    (PEcAn.utils::status.check("ADVANCED") == 0)) {
  PEcAn.utils::status.start("ADVANCED")
  q();
}

# Start ecosystem model runs
if (PEcAn.utils::status.check("MODEL") == 0) {
  PEcAn.utils::status.start("MODEL")
  PEcAn.remote::runModule.start.model.runs(settings, stop.on.error = FALSE)
  PEcAn.utils::status.end()
}

# Get results of model runs
if (PEcAn.utils::status.check("OUTPUT") == 0) {
  PEcAn.utils::status.start("OUTPUT")
  runModule.get.results(settings)
  PEcAn.utils::status.end()
}

# Run ensemble analysis on model output.
if ('ensemble' %in% names(settings) & PEcAn.utils::status.check("ENSEMBLE") == 0) {
  PEcAn.utils::status.start("ENSEMBLE")
  runModule.run.ensemble.analysis(settings, TRUE)
  PEcAn.utils::status.end()
}

# Run sensitivity analysis and variance decomposition on model output
if ('sensitivity.analysis' %in% names(settings) & PEcAn.utils::status.check("SENSITIVITY") == 0) {
  PEcAn.utils::status.start("SENSITIVITY")
  runModule.run.sensitivity.analysis(settings)
  PEcAn.utils::status.end()
}

# Run parameter data assimilation
if ('assim.batch' %in% names(settings)) {
  if (PEcAn.utils::status.check("PDA") == 0) {
    PEcAn.utils::status.start("PDA")
    settings <- PEcAn.assim.batch::runModule.assim.batch(settings)
    PEcAn.utils::status.end()
  }
}

# Run state data assimilation
if ('state.data.assimilation' %in% names(settings)) {
  if (PEcAn.utils::status.check("SDA") == 0) {
    PEcAn.utils::status.start("SDA")
    settings <- sda.enfk(settings)
    PEcAn.utils::status.end()
  }
}

# Run benchmarking
if("benchmarking" %in% names(settings) & "benchmark" %in% names(settings$benchmarking)){
  PEcAn.utils::status.start("BENCHMARKING")
  results <- papply(settings, function(x) calc_benchmark(x, bety))
  PEcAn.utils::status.end()
}

# Pecan workflow complete
if (PEcAn.utils::status.check("FINISHED") == 0) {
  PEcAn.utils::status.start("FINISHED")
  PEcAn.remote::kill.tunnel(settings)
  db.query(paste("UPDATE workflows SET finished_at=NOW() WHERE id=",
                 settings$workflow$id, "AND finished_at IS NULL"),
           params = settings$database$bety)
  
  # Send email if configured
  if (!is.null(settings$email) && !is.null(settings$email$to) && (settings$email$to != "")) {
    sendmail(settings$email$from, settings$email$to,
             paste0("Workflow has finished executing at ", base::date()),
             paste0("You can find the results on ", settings$email$url))
  }
  PEcAn.utils::status.end()
}

db.print.connections()
print("---------- PEcAn Workflow Complete ----------")
```

6.  Generate control weather data `danforth-control-chamber.2019.csv`
    with this R script `generate_control_weather.R`.

<!-- end list -->

``` r
controlchamber_weather <- data.frame(year = rep(2019, 8760), 
                                      doy = rep(1:365, each = 24), 
                                      hour = rep(seq(0, 23), 365), 
                                      SolarR = rep(c(rep(0, each = 8), rep(936, each = 12), rep(0, each = 4)), times = 365),
                                      Temp = rep(c(rep(22, each = 8), rep(31, each = 12), rep(22, each = 4)), times = 365),
                                      RH = rep(55.5 / 100,  times = 365 * 24), 
                                      WS = rep(0, times = 365 * 24), 
                                      precip = rep(c(0.000462963, rep(0, 23)), 365))

write.csv(controlchamber_weather, "biocro_temp_exps_files1/danforth-control-chamber.2019.csv", 
          row.names = FALSE)
```

7.  To run model for control
treatment.

<!-- end list -->

``` bash
biocro_temp_exps_files1/workflow.R --settings biocro_temp_exps_files1/pecan.biocro.darpa.temp.exps1.xml
```

8.  Plot results against measured biomass. Download control data from
    [Google
    Drive](https://docs.google.com/spreadsheets/d/134qzz1mcfKyGSS4vMOh0CONUECUuMiDyp6D_pzGjfi0/edit#gid=1249864874)
    sheet labeled 5th\_Biomass\_A10\&ME034\_cycling\_temp as csv. Save
    file as `control_biomass.csv`.

Create a script called `plot_results1.R`, which will contain following
code. This cleans up the biomass data, calculating number of days
between treatment starting and biomass harvest, and converts biomass
units from milligrams to megagrams per hectare (each plant grown in pot
with 103 cm2 area).

This also pulls in and cleans up the biomass data estimated from BioCro,
then plots biomass measurements against this.

``` r
# Libraries
library(udunits2)
library(dplyr)
library(data.table)
library(tidyr)
library(ggplot2)

# Clean up biomass data
area_cm2 <- 103
area_ha <- ud.convert(area_cm2, "cm2", "ha")
control_biomass <- read.csv("biocro_temp_exps_files1/control_biomass.csv") %>% 
  filter(genotype == "ME034V-1", temperature...C..day.night == "31/22", 
         sample_for == "biomass") %>% 
  mutate(days_grown = as.integer(as.Date(as.character(biomass.harvested), format = "%m/%d/%Y") - 
                                   as.integer(as.Date(as.character(treatment.started), format = "%m/%d/%Y"))), 
         total_biomass_mg = panicle_DW_mg + stem_DW_mg + leaf_DW_mg + roots_DW_mg, 
         total_biomass_Mgha = ud.convert(total_biomass_mg, "mg", "Mg") / area_ha) %>% 
  filter(!is.na(total_biomass_Mgha))
write.csv(control_biomass, "biocro_temp_exps_files1/control_biomass_meas.csv")

# Clean up biomass estimates
load('~/biocro_temp_exps_results1/out/SA-median/biocro_output.RData')
timescale <- data.table(day = rep(biocro_result$doy, each = 24), hour = 0:23)
rm(biocro_result)

load("~/biocro_temp_exps_results1/ensemble.ts.NOENSEMBLEID.TotLivBiom.2019.2019.Rdata")
daily_biomass <- data.frame(timescale, t(ensemble.ts[["TotLivBiom"]])) %>% 
  gather(ensemble, biomass, X1:X10) %>% 
  group_by(day, hour) %>% 
  summarise(mean = mean(biomass, na.rm = TRUE), 
            median = median(biomass, na.rm = TRUE), 
            sd = sd(biomass, na.rm = TRUE), 
            lcl = quantile(biomass, probs = c(0.025), na.rm = TRUE), 
            ucl = quantile(biomass, probs = c(0.975), na.rm = TRUE)) %>% 
  group_by(day) %>% 
  summarise(mean = sum(mean), 
            median = sum(median), 
            sd = sqrt(sum(sd^2)), 
            lcl = sum(lcl), 
            ucl = sum(ucl))
write.csv(daily_biomass, "biocro_temp_exps_files1/biomass_ests1.csv")
rm(ensemble.ts)

# Plot measured biomass against biomass estimates
sd_scale <- 5
ggplot(data = daily_biomass) + 
  geom_line(aes(day, y = mean)) +
  geom_ribbon(aes(day, ymin = mean - sd_scale * sd, ymax = mean + sd_scale * sd), alpha = 0.1) +
  geom_ribbon(aes(day, ymin = lcl, ymax = ucl), alpha = 0.1) +
  #geom_point(data = control_biomass, aes(x = days_grown, y = total_biomass_Mgha)) +
  xlab("Day of Year") + 
  ylab("Total Biomass Mg/ha") +
  theme_classic()
```

# Section 2: BioCro Run for Control Parameters & High Night Temperature Weather

1.  Access RStudio in a browser by navigating to
    <welsch.cyverse.org:8787/>. Log in using your username and password.

2.  Create a new folder called `biocro_temp_exps_files2`.

3.  Create new XML called `pecan.biocro.darpa.temp.exps2.xml`

<!-- end list -->

``` r
<pecan>
  <outdir>biocro_temp_exps_results2</outdir>

  <database>
    <bety>
      <driver>PostgreSQL</driver>
      <user>bety</user>
      <password>bety</password>
      <host>postgres</host>
      <dbname>bety</dbname>
      <write>FALSE</write>
    </bety>
    <dbfiles>biocro_temp_exps_results2/dbfiles</dbfiles>
  </database>

  <pfts>
    <pft>
      <name>SetariaWT_ME034</name>
      <constants>
        <file>biocro_temp_exps_files2/setaria.constants.xml</file>
      </constants>
    </pft>
  </pfts>

  <ensemble>
    <size>10</size>
    <variable>TotLivBiom</variable>
  </ensemble>

  <meta.analysis>
    <iter>3000</iter>
    <random.effects>TRUE</random.effects>
    <threshold>1.2</threshold>
    <update>AUTO</update>
  </meta.analysis>

  <sensitivity.analysis>
    <variable>TotLivBiom</variable>
  </sensitivity.analysis>

  <model>
    <type>BIOCRO</type>
    <binary>/home/kristinariemer/pecan/models/biocro/inst/biocro.Rscript</binary>
    <revision>0.95</revision>
  </model>

  <run>
    <site>
      <id>9000000004</id>
    </site>
    <inputs>
      <met>
        <output>BIOCRO</output>
        <path>/home/kristinariemer/biocro_temp_exps_files2/danforth-highnight-chamber</path>
      </met>
    </inputs>
      <start.date>2019/01/01</start.date>
      <end.date>2019/12/30</end.date>
    <host>
      <name>localhost</name>
    </host>
  </run>
</pecan>
```

4.  Create Setaria constants file `setaria.constants.xml`. This has
    biomass coefficients and starting biomass values. The same will be
    used for all runs.

<!-- end list -->

``` r
<constants>
  <type>
    <photosynthesis>C4</photosynthesis>
    <genus>Setaria</genus>
  </type>
  <canopyControl>
    <Sp>1.7</Sp>
    <SpD>0</SpD>
    <nlayers>10</nlayers>
    <kd>0.1</kd>
    <chi.l>1</chi.l>
    <mResp>0.02,0.03</mResp>
    <heightFactor>3</heightFactor>
    <leafwidth>0.04</leafwidth>
    <eteq>0</eteq>
  </canopyControl>
  <iPlantControl>
    <iRhizome>0.001</iRhizome>
    <iStem>0.001</iStem>
    <iLeaf>0.001</iLeaf>
    <iRoot>0.001</iRoot>
    <ifrRhizome>0.01</ifrRhizome>
    <ifrStem>0.01</ifrStem> 
  </iPlantControl>
  <photoParms>
    <vmax>39</vmax>
    <alpha>0.04</alpha>
    <kparm>0.7</kparm>
    <theta>0.83</theta>
    <beta>0.93</beta>
    <Rd>0.8</Rd>
    <Catm>500</Catm>
    <b0>0.01</b0>
    <b1>3</b1>
    <ws>1</ws>
    <UPPERTEMP>37.5</UPPERTEMP>
    <LOWERTEMP>3</LOWERTEMP>
  </photoParms>
  <phenoControl>
    <Tbase>0</Tbase>
  </phenoControl>
  <seneControl>
    <senLeaf>3000</senLeaf>
    <senStem>3500</senStem>
    <senRoot>4000</senRoot>
    <senRhizome>4000</senRhizome>
  </seneControl>
  <soilControl>
    <FieldC>-1</FieldC>
    <WiltP>-1</WiltP>
    <phi1>0.01</phi1>
    <phi2>10</phi2>
    <soilDepth>1</soilDepth>
    <iWatCont>0.32</iWatCont>
    <soilType>6</soilType>
    <soilLayers>1</soilLayers>
    <soilDepths/>
    <wsFun>0</wsFun>
    <scsf>1</scsf>
    <transpRes>5000000</transpRes>
    <leafPotTh>-800</leafPotTh>
    <hydrDist>0</hydrDist>
    <rfl>0.2</rfl>
    <rsec>0.2</rsec>
    <rsdf>0.44</rsdf>
  </soilControl>
  <phenoParms>
    <tp1>150</tp1>
    <tp2>300</tp2>
    <tp3>450</tp3>
    <tp4>600</tp4>
    <tp5>750</tp5>
    <tp6>900</tp6>
    <kStem1>0.07797131</kStem1>
    <kLeaf1>0.4574688</kLeaf1>
    <kRoot1>0.4645599</kRoot1>
    <kRhizome1>0.00000001</kRhizome1>
    <kStem2>0.3682341</kStem2>
    <kLeaf2>0.3520679</kLeaf2>
    <kRoot2>0.279698</kRoot2>
    <kRhizome2>0.00000001</kRhizome2>
    <kStem3>0.2998348</kStem3>
    <kLeaf3>0.6848535</kLeaf3>
    <kRoot3>0.01531178</kRoot3>
    <kRhizome3>0.00000001</kRhizome3>
    <kStem4>0.669772</kStem4>
    <kLeaf4>0.2855325</kLeaf4>
    <kRoot4>0.04469549</kRoot4>
    <kRhizome4>0.00000001</kRhizome4>
    <kStem5>0.1630056</kStem5>
    <kLeaf5>0.8037141</kLeaf5>
    <kRoot5>0.0332803</kRoot5>
    <kRhizome5>0.00000001</kRhizome5>
    <kStem6>0.7787245</kStem6>
    <kLeaf6>0.02861919</kLeaf6>
    <kRoot6>0.1399813</kRoot6>
    <kRhizome6>0.00000001</kRhizome6>
    <kGrain6>0.05267502</kGrain6>
  </phenoParms>
</constants>
```

5.  Create new `workflow.R`

<!-- end list -->

``` r
#!/usr/bin/env Rscript
#-------------------------------------------------------------------------------
# Copyright (c) 2012 University of Illinois, NCSA.
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the 
# University of Illinois/NCSA Open Source License
# which accompanies this distribution, and is available at
# http://opensource.ncsa.illinois.edu/license.html
#-------------------------------------------------------------------------------

# ----------------------------------------------------------------------
# Load required libraries
# ----------------------------------------------------------------------
library(PEcAn.all)
library(PEcAn.utils)
library(RCurl)

# make sure always to call status.end
options(warn=1)
options(error=quote({
  PEcAn.utils::status.end("ERROR")
  PEcAn.remote::kill.tunnel(settings)
  if (!interactive()) {
    q(status = 1)
  }
}))

#options(warning.expression=status.end("ERROR"))


# ----------------------------------------------------------------------
# PEcAn Workflow
# ----------------------------------------------------------------------
# Open and read in settings file for PEcAn run.
args <- commandArgs(trailingOnly = TRUE)
if (is.na(args[1])){
  settings <- PEcAn.settings::read.settings("pecan.xml") 
} else {
  settings.file <- args[1]
  settings <- PEcAn.settings::read.settings(settings.file)
}

# Check for additional modules that will require adding settings
if("benchmarking" %in% names(settings)){
  library(PEcAn.benchmark)
  settings <- papply(settings, read_settings_BRR)
}

if("sitegroup" %in% names(settings)){
  if(is.null(settings$sitegroup$nSite)){
    settings <- PEcAn.settings::createSitegroupMultiSettings(settings, 
                                                             sitegroupId = settings$sitegroup$id)
  } else {
    settings <- PEcAn.settings::createSitegroupMultiSettings(settings, 
                                                             sitegroupId = settings$sitegroup$id,
                                                             nSite = settings$sitegroup$nSite)
  }
  settings$sitegroup <- NULL ## zero out so don't expand a second time if re-reading
}

# Update/fix/check settings. Will only run the first time it's called, unless force=TRUE
settings <- PEcAn.settings::prepare.settings(settings, force = FALSE)

# Write pecan.CHECKED.xml
PEcAn.settings::write.settings(settings, outputfile = "pecan.CHECKED.xml")

# start from scratch if no continue is passed in
statusFile <- file.path(settings$outdir, "STATUS")
if (length(which(commandArgs() == "--continue")) == 0 && file.exists(statusFile)) {
  file.remove(statusFile)
}

# Do conversions
settings <- PEcAn.workflow::do_conversions(settings)

# Query the trait database for data and priors
if (PEcAn.utils::status.check("TRAIT") == 0){
  PEcAn.utils::status.start("TRAIT")
  settings <- PEcAn.workflow::runModule.get.trait.data(settings)
  PEcAn.settings::write.settings(settings, outputfile='pecan.TRAIT.xml')
  PEcAn.utils::status.end()
} else if (file.exists(file.path(settings$outdir, 'pecan.TRAIT.xml'))) {
  settings <- PEcAn.settings::read.settings(file.path(settings$outdir, 'pecan.TRAIT.xml'))
}

library(dplyr)
trait <- read.csv("biocro_temp_exps_results2/pft/SetariaWT_ME034/trait.data.csv") %>%
  filter(mean < 25)
write.csv(trait, "biocro_temp_exps_results2/pft/SetariaWT_ME034/trait.data.csv")

load("biocro_temp_exps_results2/pft/SetariaWT_ME034/trait.data.Rdata")
file.remove("biocro_temp_exps_results2/pft/SetariaWT_ME034/trait.data.Rdata")
trait.data$Vcmax <- trait.data$Vcmax[4:15,]
save(trait.data, file = "/home/kristinariemer/biocro_temp_exps_results2/pft/SetariaWT_ME034/trait.data.Rdata")

# Run the PEcAn meta.analysis
if(!is.null(settings$meta.analysis)) {
  if (PEcAn.utils::status.check("META") == 0){
    PEcAn.utils::status.start("META")
    PEcAn.MA::runModule.run.meta.analysis(settings)
    PEcAn.utils::status.end()
  }
}

# Write model specific configs
if (PEcAn.utils::status.check("CONFIG") == 0){
  PEcAn.utils::status.start("CONFIG")
  settings <- PEcAn.workflow::runModule.run.write.configs(settings)
  PEcAn.settings::write.settings(settings, outputfile='pecan.CONFIGS.xml')
  PEcAn.utils::status.end()
} else if (file.exists(file.path(settings$outdir, 'pecan.CONFIGS.xml'))) {
  settings <- PEcAn.settings::read.settings(file.path(settings$outdir, 'pecan.CONFIGS.xml'))
}

if ((length(which(commandArgs() == "--advanced")) != 0) && 
    (PEcAn.utils::status.check("ADVANCED") == 0)) {
  PEcAn.utils::status.start("ADVANCED")
  q();
}

# Start ecosystem model runs
if (PEcAn.utils::status.check("MODEL") == 0) {
  PEcAn.utils::status.start("MODEL")
  PEcAn.remote::runModule.start.model.runs(settings, stop.on.error = FALSE)
  PEcAn.utils::status.end()
}

# Get results of model runs
if (PEcAn.utils::status.check("OUTPUT") == 0) {
  PEcAn.utils::status.start("OUTPUT")
  runModule.get.results(settings)
  PEcAn.utils::status.end()
}

# Run ensemble analysis on model output.
if ('ensemble' %in% names(settings) & PEcAn.utils::status.check("ENSEMBLE") == 0) {
  PEcAn.utils::status.start("ENSEMBLE")
  runModule.run.ensemble.analysis(settings, TRUE)
  PEcAn.utils::status.end()
}

# Run sensitivity analysis and variance decomposition on model output
if ('sensitivity.analysis' %in% names(settings) & PEcAn.utils::status.check("SENSITIVITY") == 0) {
  PEcAn.utils::status.start("SENSITIVITY")
  runModule.run.sensitivity.analysis(settings)
  PEcAn.utils::status.end()
}

# Run parameter data assimilation
if ('assim.batch' %in% names(settings)) {
  if (PEcAn.utils::status.check("PDA") == 0) {
    PEcAn.utils::status.start("PDA")
    settings <- PEcAn.assim.batch::runModule.assim.batch(settings)
    PEcAn.utils::status.end()
  }
}

# Run state data assimilation
if ('state.data.assimilation' %in% names(settings)) {
  if (PEcAn.utils::status.check("SDA") == 0) {
    PEcAn.utils::status.start("SDA")
    settings <- sda.enfk(settings)
    PEcAn.utils::status.end()
  }
}

# Run benchmarking
if("benchmarking" %in% names(settings) & "benchmark" %in% names(settings$benchmarking)){
  PEcAn.utils::status.start("BENCHMARKING")
  results <- papply(settings, function(x) calc_benchmark(x, bety))
  PEcAn.utils::status.end()
}

# Pecan workflow complete
if (PEcAn.utils::status.check("FINISHED") == 0) {
  PEcAn.utils::status.start("FINISHED")
  PEcAn.remote::kill.tunnel(settings)
  db.query(paste("UPDATE workflows SET finished_at=NOW() WHERE id=",
                 settings$workflow$id, "AND finished_at IS NULL"),
           params = settings$database$bety)
  
  # Send email if configured
  if (!is.null(settings$email) && !is.null(settings$email$to) && (settings$email$to != "")) {
    sendmail(settings$email$from, settings$email$to,
             paste0("Workflow has finished executing at ", base::date()),
             paste0("You can find the results on ", settings$email$url))
  }
  PEcAn.utils::status.end()
}

db.print.connections()
print("---------- PEcAn Workflow Complete ----------")
```

6.  Generate high night temperature weather data
    `danforth-highnight-chamber.2019.csv` with this R script
    `generate_highnight_weather.R`.

<!-- end list -->

``` r
hightempchamber_weather <- data.frame(year = rep(2019, 8760), 
                                      doy = rep(1:365, each = 24), 
                                      hour = rep(seq(0, 23), 365), 
                                      SolarR = rep(c(rep(0, each = 8), rep(936, each = 12), rep(0, each = 4)), times = 365),
                                      Temp = rep(31, times = 365 * 24), 
                                      RH = rep(55.5 / 100,  times = 365 * 24), 
                                      WS = rep(0, times = 365 * 24), 
                                      precip = rep(c(0.000462963, rep(0, 23)), 365))

write.csv(hightempchamber_weather, "biocro_temp_exps_files2/danforth-highnight-chamber.2019.csv", 
          row.names = FALSE)
```

7.  To run model for control parameters with high night time temp
    weather. (`biocro_temp_exps_results1` folder may have to be moved
    somewhere else
temporarily)

<!-- end list -->

``` bash
biocro_temp_exps_files2/workflow.R --settings biocro_temp_exps_files2/pecan.biocro.darpa.temp.exps2.xml
```

8.  Plot biomass results. Create a script called `plot_results2.R`,
    which will contain following code. This pulls in and cleans up the
    biomass data estimated from BioCro, then plots the data.

<!-- end list -->

``` r
# Libraries
library(dplyr)
library(data.table)
library(tidyr)
library(ggplot2)

# Clean up biomass estimates
load('~/biocro_temp_exps_results2/out/SA-median/biocro_output.RData')
timescale <- data.table(day = rep(biocro_result$doy, each = 24), hour = 0:23)
rm(biocro_result)

load("~/biocro_temp_exps_results2/ensemble.ts.NOENSEMBLEID.TotLivBiom.2019.2019.Rdata")
daily_biomass <- data.frame(timescale, t(ensemble.ts[["TotLivBiom"]])) %>% 
  gather(ensemble, biomass, X1:X10) %>% 
  group_by(day, hour) %>% 
  summarise(mean = mean(biomass, na.rm = TRUE), 
            median = median(biomass, na.rm = TRUE), 
            sd = sd(biomass, na.rm = TRUE), 
            lcl = quantile(biomass, probs = c(0.025), na.rm = TRUE), 
            ucl = quantile(biomass, probs = c(0.975), na.rm = TRUE)) %>% 
  group_by(day) %>% 
  summarise(mean = sum(mean), 
            median = sum(median), 
            sd = sqrt(sum(sd^2)), 
            lcl = sum(lcl), 
            ucl = sum(ucl))
write.csv(daily_biomass, "biocro_temp_exps_files2/biomass_ests2.csv")
rm(ensemble.ts)

# Plot measured biomass against biomass estimates
sd_scale <- 5
ggplot(data = daily_biomass) + 
  geom_line(aes(day, y = mean)) +
  geom_ribbon(aes(day, ymin = mean - sd_scale * sd, ymax = mean + sd_scale * sd), alpha = 0.1) +
  geom_ribbon(aes(day, ymin = lcl, ymax = ucl), alpha = 0.1) +
  xlab("Day of Year") + 
  ylab("Total Biomass Mg/ha") +
  theme_classic()
```

# Section 3: BioCro Run for High Night Temperature Parameters & Weather

1.  Access RStudio in a browser by navigating to
    <welsch.cyverse.org:8787/>. Log in using your username and password.

2.  Create a new folder called `biocro_temp_exps_files3`.

3.  Create new XML called `pecan.biocro.darpa.temp.exps3.xml`

<!-- end list -->

``` r
<pecan>
  <outdir>biocro_temp_exps_results3</outdir>

  <database>
    <bety>
      <driver>PostgreSQL</driver>
      <user>bety</user>
      <password>bety</password>
      <host>postgres</host>
      <dbname>bety</dbname>
      <write>FALSE</write>
    </bety>
    <dbfiles>biocro_temp_exps_results3/dbfiles</dbfiles>
  </database>

  <pfts>
    <pft>
      <name>SetariaWT_ME034</name>
      <constants>
        <file>biocro_temp_exps_files3/setaria.constants.xml</file>
      </constants>
    </pft>
  </pfts>

  <ensemble>
    <size>10</size>
    <variable>TotLivBiom</variable>
  </ensemble>

  <meta.analysis>
    <iter>3000</iter>
    <random.effects>TRUE</random.effects>
    <threshold>1.2</threshold>
    <update>AUTO</update>
  </meta.analysis>

  <sensitivity.analysis>
    <variable>TotLivBiom</variable>
  </sensitivity.analysis>

  <model>
    <type>BIOCRO</type>
    <binary>/home/kristinariemer/pecan/models/biocro/inst/biocro.Rscript</binary>
    <revision>0.95</revision>
  </model>

  <run>
    <site>
      <id>9000000004</id>
    </site>
    <inputs>
      <met>
        <output>BIOCRO</output>
        <path>/home/kristinariemer/biocro_temp_exps_files3/danforth-highnight-chamber</path>
      </met>
    </inputs>
      <start.date>2019/01/01</start.date>
      <end.date>2019/12/30</end.date>
    <host>
      <name>localhost</name>
    </host>
  </run>
</pecan>
```

4.  Create Setaria constants file `setaria.constants.xml`. This has
    biomass coefficients and starting biomass values. The same will be
    used for all runs.

<!-- end list -->

``` r
<constants>
  <type>
    <photosynthesis>C4</photosynthesis>
    <genus>Setaria</genus>
  </type>
  <canopyControl>
    <Sp>1.7</Sp>
    <SpD>0</SpD>
    <nlayers>10</nlayers>
    <kd>0.1</kd>
    <chi.l>1</chi.l>
    <mResp>0.02,0.03</mResp>
    <heightFactor>3</heightFactor>
    <leafwidth>0.04</leafwidth>
    <eteq>0</eteq>
  </canopyControl>
  <iPlantControl>
    <iRhizome>0.001</iRhizome>
    <iStem>0.001</iStem>
    <iLeaf>0.001</iLeaf>
    <iRoot>0.001</iRoot>
    <ifrRhizome>0.01</ifrRhizome>
    <ifrStem>0.01</ifrStem> 
  </iPlantControl>
  <photoParms>
    <vmax>39</vmax>
    <alpha>0.04</alpha>
    <kparm>0.7</kparm>
    <theta>0.83</theta>
    <beta>0.93</beta>
    <Rd>0.8</Rd>
    <Catm>500</Catm>
    <b0>0.01</b0>
    <b1>3</b1>
    <ws>1</ws>
    <UPPERTEMP>37.5</UPPERTEMP>
    <LOWERTEMP>3</LOWERTEMP>
  </photoParms>
  <phenoControl>
    <Tbase>0</Tbase>
  </phenoControl>
  <seneControl>
    <senLeaf>3000</senLeaf>
    <senStem>3500</senStem>
    <senRoot>4000</senRoot>
    <senRhizome>4000</senRhizome>
  </seneControl>
  <soilControl>
    <FieldC>-1</FieldC>
    <WiltP>-1</WiltP>
    <phi1>0.01</phi1>
    <phi2>10</phi2>
    <soilDepth>1</soilDepth>
    <iWatCont>0.32</iWatCont>
    <soilType>6</soilType>
    <soilLayers>1</soilLayers>
    <soilDepths/>
    <wsFun>0</wsFun>
    <scsf>1</scsf>
    <transpRes>5000000</transpRes>
    <leafPotTh>-800</leafPotTh>
    <hydrDist>0</hydrDist>
    <rfl>0.2</rfl>
    <rsec>0.2</rsec>
    <rsdf>0.44</rsdf>
  </soilControl>
  <phenoParms>
    <tp1>150</tp1>
    <tp2>300</tp2>
    <tp3>450</tp3>
    <tp4>600</tp4>
    <tp5>750</tp5>
    <tp6>900</tp6>
    <kStem1>0.07797131</kStem1>
    <kLeaf1>0.4574688</kLeaf1>
    <kRoot1>0.4645599</kRoot1>
    <kRhizome1>0.00000001</kRhizome1>
    <kStem2>0.3682341</kStem2>
    <kLeaf2>0.3520679</kLeaf2>
    <kRoot2>0.279698</kRoot2>
    <kRhizome2>0.00000001</kRhizome2>
    <kStem3>0.2998348</kStem3>
    <kLeaf3>0.6848535</kLeaf3>
    <kRoot3>0.01531178</kRoot3>
    <kRhizome3>0.00000001</kRhizome3>
    <kStem4>0.669772</kStem4>
    <kLeaf4>0.2855325</kLeaf4>
    <kRoot4>0.04469549</kRoot4>
    <kRhizome4>0.00000001</kRhizome4>
    <kStem5>0.1630056</kStem5>
    <kLeaf5>0.8037141</kLeaf5>
    <kRoot5>0.0332803</kRoot5>
    <kRhizome5>0.00000001</kRhizome5>
    <kStem6>0.7787245</kStem6>
    <kLeaf6>0.02861919</kLeaf6>
    <kRoot6>0.1399813</kRoot6>
    <kRhizome6>0.00000001</kRhizome6>
    <kGrain6>0.05267502</kGrain6>
  </phenoParms>
</constants>
```

5.  Create new `workflow.R`

<!-- end list -->

``` r
#!/usr/bin/env Rscript
#-------------------------------------------------------------------------------
# Copyright (c) 2012 University of Illinois, NCSA.
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the 
# University of Illinois/NCSA Open Source License
# which accompanies this distribution, and is available at
# http://opensource.ncsa.illinois.edu/license.html
#-------------------------------------------------------------------------------

# ----------------------------------------------------------------------
# Load required libraries
# ----------------------------------------------------------------------
library(PEcAn.all)
library(PEcAn.utils)
library(RCurl)

# make sure always to call status.end
options(warn=1)
options(error=quote({
  PEcAn.utils::status.end("ERROR")
  PEcAn.remote::kill.tunnel(settings)
  if (!interactive()) {
    q(status = 1)
  }
}))

#options(warning.expression=status.end("ERROR"))


# ----------------------------------------------------------------------
# PEcAn Workflow
# ----------------------------------------------------------------------
# Open and read in settings file for PEcAn run.
args <- commandArgs(trailingOnly = TRUE)
if (is.na(args[1])){
  settings <- PEcAn.settings::read.settings("pecan.xml") 
} else {
  settings.file <- args[1]
  settings <- PEcAn.settings::read.settings(settings.file)
}

# Check for additional modules that will require adding settings
if("benchmarking" %in% names(settings)){
  library(PEcAn.benchmark)
  settings <- papply(settings, read_settings_BRR)
}

if("sitegroup" %in% names(settings)){
  if(is.null(settings$sitegroup$nSite)){
    settings <- PEcAn.settings::createSitegroupMultiSettings(settings, 
                                                             sitegroupId = settings$sitegroup$id)
  } else {
    settings <- PEcAn.settings::createSitegroupMultiSettings(settings, 
                                                             sitegroupId = settings$sitegroup$id,
                                                             nSite = settings$sitegroup$nSite)
  }
  settings$sitegroup <- NULL ## zero out so don't expand a second time if re-reading
}

# Update/fix/check settings. Will only run the first time it's called, unless force=TRUE
settings <- PEcAn.settings::prepare.settings(settings, force = FALSE)

# Write pecan.CHECKED.xml
PEcAn.settings::write.settings(settings, outputfile = "pecan.CHECKED.xml")

# start from scratch if no continue is passed in
statusFile <- file.path(settings$outdir, "STATUS")
if (length(which(commandArgs() == "--continue")) == 0 && file.exists(statusFile)) {
  file.remove(statusFile)
}

# Do conversions
settings <- PEcAn.workflow::do_conversions(settings)

# Query the trait database for data and priors
if (PEcAn.utils::status.check("TRAIT") == 0){
  PEcAn.utils::status.start("TRAIT")
  settings <- PEcAn.workflow::runModule.get.trait.data(settings)
  PEcAn.settings::write.settings(settings, outputfile='pecan.TRAIT.xml')
  PEcAn.utils::status.end()
} else if (file.exists(file.path(settings$outdir, 'pecan.TRAIT.xml'))) {
  settings <- PEcAn.settings::read.settings(file.path(settings$outdir, 'pecan.TRAIT.xml'))
}

library(dplyr)
trait <- read.csv("biocro_temp_exps_results3/pft/SetariaWT_ME034/trait.data.csv") %>%
  filter(mean < 25)
write.csv(trait, "biocro_temp_exps_results3/pft/SetariaWT_ME034/trait.data.csv")

load("biocro_temp_exps_results3/pft/SetariaWT_ME034/trait.data.Rdata")
file.remove("biocro_temp_exps_results3/pft/SetariaWT_ME034/trait.data.Rdata")
trait.data$Vcmax <- trait.data$Vcmax[4:15,]
save(trait.data, file = "/home/kristinariemer/biocro_temp_exps_results3/pft/SetariaWT_ME034/trait.data.Rdata")

# Run the PEcAn meta.analysis
if(!is.null(settings$meta.analysis)) {
  if (PEcAn.utils::status.check("META") == 0){
    PEcAn.utils::status.start("META")
    PEcAn.MA::runModule.run.meta.analysis(settings)
    PEcAn.utils::status.end()
  }
}

load("~/biocro_temp_exps_results3/pft/SetariaWT_ME034/trait.mcmc.Rdata")
for(trait_name in names(trait.mcmc)){
  for(chain in 1:4){
    trait.mcmc[[trait_name]][[chain]][,"beta.o"] <- trait.mcmc[[trait_name]][[chain]][,"beta.o"] + trait.mcmc[[trait_name]][[chain]][,"beta.trt[2]"]
  }
}
save(trait.mcmc, file = "/home/kristinariemer/biocro_temp_exps_results3/pft/SetariaWT_ME034/trait.mcmc.Rdata")
rm(trait.mcmc)

# Write model specific configs
if (PEcAn.utils::status.check("CONFIG") == 0){
  PEcAn.utils::status.start("CONFIG")
  settings <- PEcAn.workflow::runModule.run.write.configs(settings)
  PEcAn.settings::write.settings(settings, outputfile='pecan.CONFIGS.xml')
  PEcAn.utils::status.end()
} else if (file.exists(file.path(settings$outdir, 'pecan.CONFIGS.xml'))) {
  settings <- PEcAn.settings::read.settings(file.path(settings$outdir, 'pecan.CONFIGS.xml'))
}

if ((length(which(commandArgs() == "--advanced")) != 0) && 
    (PEcAn.utils::status.check("ADVANCED") == 0)) {
  PEcAn.utils::status.start("ADVANCED")
  q();
}

# Start ecosystem model runs
if (PEcAn.utils::status.check("MODEL") == 0) {
  PEcAn.utils::status.start("MODEL")
  PEcAn.remote::runModule.start.model.runs(settings, stop.on.error = FALSE)
  PEcAn.utils::status.end()
}

# Get results of model runs
if (PEcAn.utils::status.check("OUTPUT") == 0) {
  PEcAn.utils::status.start("OUTPUT")
  runModule.get.results(settings)
  PEcAn.utils::status.end()
}

# Run ensemble analysis on model output.
if ('ensemble' %in% names(settings) & PEcAn.utils::status.check("ENSEMBLE") == 0) {
  PEcAn.utils::status.start("ENSEMBLE")
  runModule.run.ensemble.analysis(settings, TRUE)
  PEcAn.utils::status.end()
}

# Run sensitivity analysis and variance decomposition on model output
if ('sensitivity.analysis' %in% names(settings) & PEcAn.utils::status.check("SENSITIVITY") == 0) {
  PEcAn.utils::status.start("SENSITIVITY")
  runModule.run.sensitivity.analysis(settings)
  PEcAn.utils::status.end()
}

# Run parameter data assimilation
if ('assim.batch' %in% names(settings)) {
  if (PEcAn.utils::status.check("PDA") == 0) {
    PEcAn.utils::status.start("PDA")
    settings <- PEcAn.assim.batch::runModule.assim.batch(settings)
    PEcAn.utils::status.end()
  }
}

# Run state data assimilation
if ('state.data.assimilation' %in% names(settings)) {
  if (PEcAn.utils::status.check("SDA") == 0) {
    PEcAn.utils::status.start("SDA")
    settings <- sda.enfk(settings)
    PEcAn.utils::status.end()
  }
}

# Run benchmarking
if("benchmarking" %in% names(settings) & "benchmark" %in% names(settings$benchmarking)){
  PEcAn.utils::status.start("BENCHMARKING")
  results <- papply(settings, function(x) calc_benchmark(x, bety))
  PEcAn.utils::status.end()
}

# Pecan workflow complete
if (PEcAn.utils::status.check("FINISHED") == 0) {
  PEcAn.utils::status.start("FINISHED")
  PEcAn.remote::kill.tunnel(settings)
  db.query(paste("UPDATE workflows SET finished_at=NOW() WHERE id=",
                 settings$workflow$id, "AND finished_at IS NULL"),
           params = settings$database$bety)
  
  # Send email if configured
  if (!is.null(settings$email) && !is.null(settings$email$to) && (settings$email$to != "")) {
    sendmail(settings$email$from, settings$email$to,
             paste0("Workflow has finished executing at ", base::date()),
             paste0("You can find the results on ", settings$email$url))
  }
  PEcAn.utils::status.end()
}

db.print.connections()
print("---------- PEcAn Workflow Complete ----------")
```

6.  Generate high night temperature weather data
    `danforth-highnight-chamber.2019.csv` with this R script
    `generate_highnight_weather.R`.

<!-- end list -->

``` r
hightempchamber_weather <- data.frame(year = rep(2019, 8760), 
                                      doy = rep(1:365, each = 24), 
                                      hour = rep(seq(0, 23), 365), 
                                      SolarR = rep(c(rep(0, each = 8), rep(936, each = 12), rep(0, each = 4)), times = 365),
                                      Temp = rep(31, times = 365 * 24), 
                                      RH = rep(55.5 / 100,  times = 365 * 24), 
                                      WS = rep(0, times = 365 * 24), 
                                      precip = rep(c(0.000462963, rep(0, 23)), 365))

write.csv(hightempchamber_weather, "biocro_temp_exps_files3/danforth-highnight-chamber.2019.csv", 
          row.names = FALSE)
```

7.  To run model for control parameters with high night time temp
    weather. (`biocro_temp_exps_results1` folder may have to be moved
    somewhere else
temporarily)

<!-- end list -->

``` bash
biocro_temp_exps_files3/workflow.R --settings biocro_temp_exps_files3/pecan.biocro.darpa.temp.exps3.xml
```

8.  Plot biomass results. Create a script called `plot_results3.R`,
    which will contain following code. This pulls in and cleans up the
    biomass data estimated from BioCro, then plots the data.

<!-- end list -->

``` r
# Libraries
library(udunits2)
library(dplyr)
library(data.table)
library(tidyr)
library(ggplot2)

# Clean up biomass data
# should this be filtered by light?
area_cm2 <- 103
area_ha <- ud.convert(area_cm2, "cm2", "ha")
highnight_biomass <- read.csv("biocro_temp_exps_files3/highnight_biomass.csv") %>% 
  filter(genotype == "ME034V-1", temperature...C..day.night == 31, 
         treatment == "control", sample_for == "biomass") %>% 
  mutate(days_grown = as.integer(as.Date(as.character(biomas.harvested), format = "%m/%d/%Y") - 
                                   as.integer(as.Date(as.character(temperature_treatment_started), 
                                                      format = "%m/%d/%Y"))), 
         total_biomass_mg = panicles.DW..mg. + stemDW.mg. + leaf.DW.mg. + roots.DW..mg., 
         total_biomass_Mgha = ud.convert(total_biomass_mg, "mg", "Mg") / area_ha) %>% 
  filter(!is.na(total_biomass_Mgha))
write.csv(highnight_biomass, "biocro_temp_exps_files3/highnight_biomass_meas.csv")

# Clean up biomass estimates
load('~/biocro_temp_exps_results3/out/SA-median/biocro_output.RData')
timescale <- data.table(day = rep(biocro_result$doy, each = 24), hour = 0:23)
rm(biocro_result)

load("~/biocro_temp_exps_results3/ensemble.ts.NOENSEMBLEID.TotLivBiom.2019.2019.Rdata")
daily_biomass <- data.frame(timescale, t(ensemble.ts[["TotLivBiom"]])) %>% 
  gather(ensemble, biomass, X1:X10) %>% 
  group_by(day, hour) %>% 
  summarise(mean = mean(biomass, na.rm = TRUE), 
            median = median(biomass, na.rm = TRUE), 
            sd = sd(biomass, na.rm = TRUE), 
            lcl = quantile(biomass, probs = c(0.025), na.rm = TRUE), 
            ucl = quantile(biomass, probs = c(0.975), na.rm = TRUE)) %>% 
  group_by(day) %>% 
  summarise(mean = sum(mean), 
            median = sum(median), 
            sd = sqrt(sum(sd^2)), 
            lcl = sum(lcl), 
            ucl = sum(ucl))
write.csv(daily_biomass, "biocro_temp_exps_files3/biomass_ests3.csv")
rm(ensemble.ts)

# Plot measured biomass against biomass estimates
sd_scale <- 5
ggplot(data = daily_biomass) + 
  geom_line(aes(day, y = mean)) +
  geom_ribbon(aes(day, ymin = mean - sd_scale * sd, ymax = mean + sd_scale * sd), alpha = 0.1) +
  geom_ribbon(aes(day, ymin = lcl, ymax = ucl), alpha = 0.1) +
  geom_point(data = highnight_biomass, aes(x = days_grown, y = total_biomass_Mgha)) +
  xlab("Day of Year") + 
  ylab("Total Biomass Mg/ha") +
  theme_classic()
```

# Section 4: Plot Three Runs

Code to plot the biomass estimates from the first two runs together,
along with the control data.

``` r
# Libraries
library(udunits2)
library(dplyr)
library(ggplot2)

# Read in and combine biomass measurements data
biomass_meas_control <- read.csv("biocro_temp_exps_files1/control_biomass_meas.csv") %>% 
  mutate(txt = "control") %>% 
  select(days_grown, total_biomass_Mgha, txt)
biomass_meas_highnight <- read.csv("biocro_temp_exps_files3/highnight_biomass_meas.csv") %>% 
  mutate(txt = "highnight") %>% 
  select(days_grown, total_biomass_Mgha, txt)

biomass_meas <- bind_rows(biomass_meas_control, biomass_meas_highnight)

# Read in and combine biomass estimates data
biomass_ests1 <- read.csv("biocro_temp_exps_files1/biomass_ests1.csv") %>% 
  mutate(run = 1)
biomass_ests2 <- read.csv("biocro_temp_exps_files2/biomass_ests2.csv") %>% 
  mutate(run = 2)
biomass_ests3 <- read.csv("biocro_temp_exps_files3/biomass_ests3.csv") %>% 
  mutate(run = 3)

biomass_ests <- bind_rows(biomass_ests1, biomass_ests2, biomass_ests3) %>% 
  mutate(run = as.factor(run)) #%>%
  #udunits convert from Mg/ha to g/cm2 for all data columns

# Plot measured biomass against biomass estimates
sd_scale <- 5

ggplot(data = biomass_ests) +
  geom_line(aes(day, mean, color = run)) +
  scale_color_manual(values=c("red", "black", "blue")) +
  xlim(x = c(0, 60)) +
  xlab("Day of Year") + 
  ylab("Total Biomass Mg/ha") +
  theme_classic()

ggplot(data = biomass_ests) +
  geom_line(aes(day, mean, color = run)) +
  geom_ribbon(aes(day, ymin = mean - sd_scale * sd, ymax = mean + sd_scale * sd, fill = run), alpha = 0.1) +
  scale_color_manual(values=c("red", "black", "blue", "red", "black", "blue")) +
  xlim(x = c(0, 60)) +
  xlab("Day of Year") + 
  ylab("Total Biomass Mg/ha") +
  theme_classic()

ggplot(data = biomass_ests) +
  geom_line(aes(day, mean, color = run)) +
  geom_point(data = biomass_meas, aes(x = days_grown, y = total_biomass_Mgha, color = txt)) +
  scale_color_manual(values=c("red", "black", "blue", "red", "blue")) +
  xlim(x = c(0, 60)) +
  xlab("Day of Year") + 
  ylab("Total Biomass Mg/ha") +
  theme_classic()
```