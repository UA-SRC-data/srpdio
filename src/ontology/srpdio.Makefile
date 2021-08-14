

# ----------------------------------------
# DOSDP pattern modules 
# ----------------------------------------
PATTERNDIR = ../patterns
PATTERN_OUT = modules
ACS_PATTERN_OUT = modules/acs
PATTERNS = entity_attribute plant_part_concentration chemical_concentration
PATTERN_ROOTS = $(patsubst %, $(PATTERN_OUT)/%, $(PATTERNS))
PATTERN_FILES = $(foreach n,$(PATTERN_ROOTS), $(n).owl)
ACS_PATTERNDIR = ../patterns/acs5_variable_sheets
ACS_2VAROUT = modules/acs_2vars
ACS_PATTERNS2 = age_x_disability
ACS_PATTERN2_ROOTS = $(patsubst %, $(PATTERN_OUT)/%, $(ACS_PATTERNS2))
ACS_PATTERN2_FILES = $(foreach n,$(ACS_PATTERN_ROOTS), $(n).owl)
ACS_PATTERNS3 = age_x_disability_x_poverty age_x_disability_x_insurance
ACS_3VAROUT = modules/acs_3vars
ACS_PATTERN3_ROOTS = $(patsubst %, $(PATTERN_OUT)/%, $(ACS_PATTERNS3))
ACS_PATTERN3_FILES = $(foreach n,$(ACS_PATTERN3_ROOTS), $(n).owl)


# Targets for DOSDP modules

all_modules:: $(PATTERN_FILES)

modules/%.owl:: $(PATTERNDIR)/%.csv $(PATTERNDIR)/%.yaml #curie_map.yaml
	dosdp-tools generate --obo-prefixes=true --table-format=csv --template=$(PATTERNDIR)/$*.yaml --outfile=$(PATTERN_OUT)/$*.tmp.owl --infile=$(PATTERNDIR)/$*.csv
	$(ROBOT) annotate --input $(PATTERN_OUT)/$*.tmp.owl -O http://purl.obolibrary.org/obo/srpdio/$*.owl --output $(PATTERN_OUT)/$*.owl && rm $(PATTERN_OUT)/$*.tmp.owl

all_acs_modules: acs_patterns2 acs_patterns3
acs_patterns2: $(ACS_PATTERN2_FILES)

$(ACS_2VAROUT)/%.owl: $(ACS_PATTERNDIR)/%.csv $(ACS_PATTERNDIR)/acs_2vars.yaml #curie_map.yaml
	dosdp-tools generate --obo-prefixes=true --table-format=csv --template=$(PATTERNDIR)/acs_2vars.yaml --outfile=$(ACS_2VAROUT)/$*.tmp.owl --infile=$(ACS_PATTERNDIR)/$*.csv
	$(ROBOT) annotate --input $(PATTERN_OUT)/$*.tmp.owl -O http://purl.obolibrary.org/obo/srpdio/$*.owl --output $(ACS_2VAROUT)/$*.owl && rm $(ACS_2VAROUT)/$*.tmp.owl

acs_patterns3: $(ACS_PATTERN3_FILES)
$(ACS_3VAROUT)/%.owl: $(ACS_PATTERNDIR)/%.csv $(ACS_PATTERNDIR)/acs_3vars.yaml #curie_map.yaml
	dosdp-tools generate --obo-prefixes=true --table-format=csv --template=$(PATTERNDIR)/acs_2vars.yaml --outfile=$(ACS_3VAROUT)/$*.tmp.owl --infile=$(ACS_PATTERNDIR)/$*.csv
	$(ROBOT) annotate --input $(PATTERN_OUT)/$*.tmp.owl -O http://purl.obolibrary.org/obo/srpdio/$*.owl --output $(ACS_3VAROUT)/$*.owl && rm $(ACS_3VAROUT)/$*.tmp.owl


#TEST PATTERNS, to make sure they work: 

#chemical_concentration.owl: ../patterns/chemical_concentration.csv ../patterns/chemical_concentration.yaml #curie_map.yaml
#	dosdp-tools generate --obo-prefixes=true --table-format=csv --template=../patterns/chemical_concentration.yaml --outfile=../patterns/chemical_concentration.tmp.owl --infile=../patterns/chemical_concentration.csv
#	$(ROBOT) annotate --input ../patterns/chemical_concentration.tmp.owl -O http://purl.obolibrary.org/obo/srpdio/chemical_concentration.owl --output ../patterns/chemical_concentration.owl && rm ../patterns/chemical_concentration.tmp.owl

#age_x_disability_x_poverty.owl: ../patterns/acs5_variable_sheets/age_x_disability_x_poverty.csv ../patterns/acs_3vars.yaml
#	dosdp-tools generate --obo-prefixes=true --table-format=csv --template=../patterns/acs_3vars.yaml --outfile=../patterns/age_x_disability_x_poverty.tmp.owl --infile=../patterns/acs5_variable_sheets/age_x_disability_x_poverty.csv
#	$(ROBOT) annotate --input ../patterns/age_x_disability_x_poverty.tmp.owl -O http://purl.obolibrary.org/obo/srpdio/age_x_disability_x_poverty.owl --output ../patterns/age_x_disability_x_poverty.owl && rm ../patterns/age_x_disability_x_poverty.tmp.owl

