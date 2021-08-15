

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

ACS_PATTERNS1 = 1computer 1nternet
ACS_OUT1 = modules/acs1
ACS_PATTERN1_ROOTS = $(patsubst %, $(ACS_OUT1)/%, $(ACS_PATTERNS1))
ACS_PATTERN1_FILES = $(foreach n,$(ACS_PATTERN1_ROOTS), $(n).owl)

ACS_PATTERNS2 = 2age_x_disability 2computer_x_internet
ACS_OUT2 = modules/acs2
ACS_PATTERN2_ROOTS = $(patsubst %, $(ACS_OUT2)/%, $(ACS_PATTERNS2))
ACS_PATTERN2_FILES = $(foreach n,$(ACS_PATTERN_ROOTS), $(n).owl)



all_acs_modules: acs_patterns1 acs_patterns2
acs_patterns1: $(ACS_PATTERN1_FILES)
acs_patterns2: $(ACS_PATTERN2_FILES)

modules/acs1/%.owl: $(ACS_PATTERNDIR)/%.csv $(PATTERNDIR)/acs_1vars.yaml #curie_map.yaml
	dosdp-tools generate --obo-prefixes=true --table-format=csv --template=$(PATTERNDIR)/acs_1vars.yaml --infile=$(ACS_PATTERNDIR)/$*.csv --outfile=$(ACS_OUT1)/$*.tmp.owl
	$(ROBOT) annotate --input $(ACS_OUT)/$*.tmp.owl -O http://purl.obolibrary.org/obo/srpdio/$*.owl --output $(ACS_OUT1)/$*.owl && rm $(ACS_OUT1)/$*.tmp.owl

$(ACS_OUT2)/%.owl: $(ACS_PATTERNDIR)/%.csv $(ACS_PATTERNDIR)/acs_2vars.yaml #curie_map.yaml
	dosdp-tools generate --obo-prefixes=true --table-format=csv --template=$(ACS_PATTERNDIR)/acs_2vars.yaml --infile=$(ACS_PATTERNDIR)/$*.csv --outfile=$(ACS_OUT2)/$*.tmp.owl 
	$(ROBOT) annotate --input $(ACS_OUT)/$*.tmp.owl -O http://purl.obolibrary.org/obo/srpdio/$*.owl --output $(ACS_OUT2)/$*.owl && rm $(ACS_OUT2)/$*.tmp.owl


