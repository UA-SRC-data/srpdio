

# ----------------------------------------
# DOSDP pattern modules 
# ----------------------------------------
PATTERNDIR = ../patterns
PATTERN_OUT = modules
ACS_PATTERN_OUT = modules/acs
PATTERNS = entity_attribute plant_part_concentration chemical_concentration
PATTERN_ROOTS = $(patsubst %, $(PATTERN_OUT)/%, $(PATTERNS))
PATTERN_FILES = $(foreach n,$(PATTERN_ROOTS), $(n).owl)


# Targets for non-acs5 DOSDP modules

all_modules:: $(PATTERN_FILES)

modules/%.owl:: $(PATTERNDIR)/%.csv $(PATTERNDIR)/%.yaml #curie_map.yaml
	dosdp-tools generate --obo-prefixes=true --table-format=csv --template=$(PATTERNDIR)/$*.yaml --infile=$(PATTERNDIR)/$*.csv --outfile=$(PATTERN_OUT)/$*.tmp.owl
	$(ROBOT) annotate --input $(PATTERN_OUT)/$*.tmp.owl -O $(ONTBASE)/$*.owl --output $(PATTERN_OUT)/$*.owl && rm $(PATTERN_OUT)/$*.tmp.owl

# Targets for acs5 DOSDP modules

ACS_PATTERNDIR = ../patterns/acs5_variable_sheets

ACS_PATTERNS1 = 1computer 1internet
ACS1 = modules/acs1
ACS_PATTERN1_ROOTS = $(patsubst %, $(ACS1)/%, $(ACS_PATTERNS1))
ACS_PATTERN1_FILES = $(foreach n,$(ACS_PATTERN1_ROOTS), $(n).owl)

ACS_PATTERNS2 = 2age_x_disability 2computer_x_internet
ACS2 = modules/acs2
ACS_PATTERN2_ROOTS = $(patsubst %, $(ACS2)/%, $(ACS_PATTERNS2))
ACS_PATTERN2_FILES = $(foreach n,$(ACS_PATTERN2_ROOTS), $(n).owl)

ACS_PATTERNS3 = 3age_x_computer_x_internet 3age_x_disability_x_insurance 3age_x_disability_x_poverty 3disability_x_grandparent_x_age 3education_x_computer_x_internet 3education_x_labor_x_language 3labor_x_employ_x_disability
ACS3 = modules/acs3
ACS_PATTERN3_ROOTS = $(patsubst %, $(ACS3)/%, $(ACS_PATTERNS3))
ACS_PATTERN3_FILES = $(foreach n,$(ACS_PATTERN3_ROOTS), $(n).owl)

.PHONY: all_acs_modules
all_acs_modules: acs_patterns1 acs_patterns2 acs_patterns3
acs_patterns1: $(ACS_PATTERN1_FILES)
acs_patterns2: $(ACS_PATTERN2_FILES)
acs_patterns3: $(ACS_PATTERN3_FILES)

$(ACS1)/%.owl: $(ACS_PATTERNDIR)/%.csv $(PATTERNDIR)/acs_1vars.yaml #curie_map.yaml
	dosdp-tools generate --obo-prefixes=true --table-format=csv --template=$(PATTERNDIR)/acs_1vars.yaml --infile=$(ACS_PATTERNDIR)/$*.csv --outfile=$(PATTERN_OUT)/$*.tmp.owl
	$(ROBOT) annotate --input $(PATTERN_OUT)/$*.tmp.owl -O http://purl.obolibrary.org/obo/srpdio/$*.owl --output $(PATTERN_OUT)/$*.owl && rm $(PATTERN_OUT)/$*.tmp.owl

$(ACS2)/%.owl: $(ACS_PATTERNDIR)/%.csv $(PATTERNDIR)/acs_2vars.yaml #curie_map.yaml
	dosdp-tools generate --obo-prefixes=true --table-format=csv --template=$(PATTERNDIR)/acs_2vars.yaml --infile=$(ACS_PATTERNDIR)/$*.csv --outfile=$(PATTERN_OUT)/$*.tmp.owl 
	$(ROBOT) annotate --input $(PATTERN_OUT)/$*.tmp.owl -O http://purl.obolibrary.org/obo/srpdio/$*.owl --output $(PATTERN_OUT)/$*.owl && rm $(PATTERN_OUT)/$*.tmp.owl

$(ACS3)/%.owl: $(ACS_PATTERNDIR)/%.csv $(PATTERNDIR)/acs_3vars.yaml #curie_map.yaml
	dosdp-tools generate --obo-prefixes=true --table-format=csv --template=$(PATTERNDIR)/acs_3vars.yaml --infile=$(ACS_PATTERNDIR)/$*.csv --outfile=$(PATTERN_OUT)/$*.tmp.owl
	$(ROBOT) annotate --input $(PATTERN_OUT)/$*.tmp.owl -O http://purl.obolibrary.org/obo/srpdio/$*.owl --output $(PATTERN_OUT)/$*.owl && rm $(PATTERN_OUT)/$*.tmp.owl



