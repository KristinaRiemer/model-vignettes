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

write.csv(setaria_initial_state, 
          file = "biomass_coeffs_1.0_inputs/setaria_initial_state.csv", 
          row.names = FALSE)

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
  iSp 2056.976
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
  topt_lower     1e4
  topt_upper    1e5
  tmax      1e6
  
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

write.csv(setaria_parameters, 
          file = "biomass_coeffs_1.0_inputs/setaria_parameters.csv", 
          row.names = FALSE)
