

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
	dosdp-tools generate --obo-prefixes=true --ontology=srpdio-edit.owl --table-format=csv --template=$(PATTERNDIR)/$*.yaml --infile=$(PATTERNDIR)/$*.csv --outfile=$(PATTERN_OUT)/$*.tmp.owl
	$(ROBOT) annotate --input $(PATTERN_OUT)/$*.tmp.owl -O $(ONTBASE)/$*.owl --output $(PATTERN_OUT)/$*.owl && rm $(PATTERN_OUT)/$*.tmp.owl

# Targets for acs5 DOSDP modules

ACS_PATTERNDIR = ../patterns/acs5_variable_sheets

ACS_PATTERNS1 = 1citizen_x_age_or_ed_or_poverty 1civ_employed_x_occupation 1computer 1income_SNAP 1income_householderage 1income_householdsize 1income_mortgage 1income_race 1internet 1ratioincome_disability
ACS1 = modules/acs1
ACS_PATTERN1_ROOTS = $(patsubst %, $(ACS1)/%, $(ACS_PATTERNS1))
ACS_PATTERN1_FILES = $(foreach n,$(ACS_PATTERN1_ROOTS), $(n).owl)

ACS_PATTERNS2 = 2age_x_disability 2civ_employed_x_sex_x_occupation 2computer_x_internet
ACS2 = modules/acs2
ACS_PATTERN2_ROOTS = $(patsubst %, $(ACS2)/%, $(ACS_PATTERNS2))
ACS_PATTERN2_FILES = $(foreach n,$(ACS_PATTERN2_ROOTS), $(n).owl)

ACS_PATTERNS3 = 3age_x_disability_x_insurance 3age_x_disability_x_poverty 3disability_x_grandparent_x_age 3education_x_computer_x_internet 3education_x_labor_x_language 3group3_x_age_x_disability 3group5_x_age_x_disability 3labor_x_employ_x_disability
ACS3 = modules/acs3
ACS_PATTERN3_ROOTS = $(patsubst %, $(ACS3)/%, $(ACS_PATTERNS3))
ACS_PATTERN3_FILES = $(foreach n,$(ACS_PATTERN3_ROOTS), $(n).owl)

ACS_PATTERNS4 = 4civilian_x_vet_x_poverty_x_disability 4computer_x_internet_x_labor_x_employ 4poverty_x_sex_x_labor_x_employ
ACS4 = modules/acs4
ACS_PATTERN4_ROOTS = $(patsubst %, $(ACS4)/%, $(ACS_PATTERNS4))
ACS_PATTERN4_FILES = $(foreach n,$(ACS_PATTERN4_ROOTS), $(n).owl)

ACS_PATTERNS5 = 5sex_x_age_x_labor_x_civ_x_employ
ACS5 = modules/acs5
ACS_PATTERN5_ROOTS = $(patsubst %, $(ACS3)/%, $(ACS_PATTERNS5))
ACS_PATTERN5_FILES = $(foreach n,$(ACS_PATTERN5_ROOTS), $(n).owl)

ACS_PATTERNS6 = 6sex_x_age_x_lab_x_civ_x_empl_x_race
ACS6 = modules/acs6
ACS_PATTERN6_ROOTS = $(patsubst %, $(ACS6)/%, $(ACS_PATTERNS6))
ACS_PATTERN6_FILES = $(foreach n,$(ACS_PATTERN6_ROOTS), $(n).owl)

.PHONY: all_acs_modules
all_acs_modules: acs_patterns1 acs_patterns2 acs_patterns3 acs_patterns4 acs_patterns5 acs_patterns6
acs_patterns1: $(ACS_PATTERN1_FILES)
acs_patterns2: $(ACS_PATTERN2_FILES)
acs_patterns3: $(ACS_PATTERN3_FILES)
acs_patterns4: $(ACS_PATTERN4_FILES)
acs_patterns5: $(ACS_PATTERN5_FILES)
acs_patterns6: $(ACS_PATTERN6_FILES)

$(ACS1)/%.owl: $(ACS_PATTERNDIR)/%.csv $(PATTERNDIR)/acs_1vars.yaml #curie_map.yaml
	dosdp-tools generate --obo-prefixes=true --table-format=csv --template=$(PATTERNDIR)/acs_1vars.yaml --infile=$(ACS_PATTERNDIR)/$*.csv --outfile=$(PATTERN_OUT)/$*.tmp.owl
	$(ROBOT) annotate --input $(PATTERN_OUT)/$*.tmp.owl -O http://purl.obolibrary.org/obo/srpdio/$*.owl --output $(PATTERN_OUT)/$*.owl && rm $(PATTERN_OUT)/$*.tmp.owl

$(ACS2)/%.owl: $(ACS_PATTERNDIR)/%.csv $(PATTERNDIR)/acs_2vars.yaml #curie_map.yaml
	dosdp-tools generate --obo-prefixes=true --table-format=csv --template=$(PATTERNDIR)/acs_2vars.yaml --infile=$(ACS_PATTERNDIR)/$*.csv --outfile=$(PATTERN_OUT)/$*.tmp.owl 
	$(ROBOT) annotate --input $(PATTERN_OUT)/$*.tmp.owl -O http://purl.obolibrary.org/obo/srpdio/$*.owl --output $(PATTERN_OUT)/$*.owl && rm $(PATTERN_OUT)/$*.tmp.owl

$(ACS3)/%.owl: $(ACS_PATTERNDIR)/%.csv $(PATTERNDIR)/acs_3vars.yaml #curie_map.yaml
	dosdp-tools generate --obo-prefixes=true --table-format=csv --template=$(PATTERNDIR)/acs_3vars.yaml --infile=$(ACS_PATTERNDIR)/$*.csv --outfile=$(PATTERN_OUT)/$*.tmp.owl
	$(ROBOT) annotate --input $(PATTERN_OUT)/$*.tmp.owl -O http://purl.obolibrary.org/obo/srpdio/$*.owl --output $(PATTERN_OUT)/$*.owl && rm $(PATTERN_OUT)/$*.tmp.owl

$(ACS4)/%.owl: $(ACS_PATTERNDIR)/%.csv $(PATTERNDIR)/acs_4vars.yaml #curie_map.yaml
	dosdp-tools generate --obo-prefixes=true --table-format=csv --template=$(PATTERNDIR)/acs_4vars.yaml --infile=$(ACS_PATTERNDIR)/$*.csv --outfile=$(PATTERN_OUT)/$*.tmp.owl
	$(ROBOT) annotate --input $(PATTERN_OUT)/$*.tmp.owl -O http://purl.obolibrary.org/obo/srpdio/$*.owl --output $(PATTERN_OUT)/$*.owl && rm $(PATTERN_OUT)/$*.tmp.owl

$(ACS5)/%.owl: $(ACS_PATTERNDIR)/%.csv $(PATTERNDIR)/acs_5vars.yaml #curie_map.yaml
	dosdp-tools generate --obo-prefixes=true --table-format=csv --template=$(PATTERNDIR)/acs_5vars.yaml --infile=$(ACS_PATTERNDIR)/$*.csv --outfile=$(PATTERN_OUT)/$*.tmp.owl
	$(ROBOT) annotate --input $(PATTERN_OUT)/$*.tmp.owl -O http://purl.obolibrary.org/obo/srpdio/$*.owl --output $(PATTERN_OUT)/$*.owl && rm $(PATTERN_OUT)/$*.tmp.owl

$(ACS6)/%.owl: $(ACS_PATTERNDIR)/%.csv $(PATTERNDIR)/acs_6vars.yaml #curie_map.yaml
	dosdp-tools generate --obo-prefixes=true --ontology=srpdio-edit.owl --table-format=csv --template=$(PATTERNDIR)/acs_6vars.yaml --infile=$(ACS_PATTERNDIR)/$*.csv --outfile=$(PATTERN_OUT)/$*.tmp.owl
	$(ROBOT) annotate --input $(PATTERN_OUT)/$*.tmp.owl -O http://purl.obolibrary.org/obo/srpdio/$*.owl --output $(PATTERN_OUT)/$*.owl && rm $(PATTERN_OUT)/$*.tmp.owl


# Merge all ACS modules

#robot merge --inputs "modules/*.owl" --output modules/all_acs.owl
#robot merge --inputs "*.owl" --output all_acs.owl
