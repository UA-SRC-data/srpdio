

# ----------------------------------------
# DOSDP pattern modules 
# ----------------------------------------
PATTERNS = chemical_concentration entity_attribute plant_part_concentration
PATTERN_ROOTS = $(patsubst %, $(PATTERNDIR)/%, $(PATTERNS))
PATTERN_FILES = $(foreach n,$(PATTERN_ROOTS), $(n).owl)

all_patterns: $(PATTERN_FILES)

# Targets for DOSDP modules
patterns/%.owl: ../patterns/%.csv ../patterns/%.yaml #curie_map.yaml
	dosdp-tools --table-format=csv --template=../patterns/$*.yaml --outfile=../pattterns/$*.tmp.owl --obo-prefixes=true generate --infile=../patterns/$*.csv
	$(ROBOT) annotate --input ../patterns/$*.tmp.owl -O http://purl.obolibrary.org/obo/srpdio/patterns/$*.owl --output ../patterns/$*.owl && rm ../patterns/$*.tmp.owl


# ----------------------------------------
# Modules (non-dosdp, not imports)
# ----------------------------------------

MODULES = SRPDIO_internal_vocab
ALL_MODS_OWL = $(patsubst %, modules/%.owl, $(MODULES))
ALL_MODS_CSV = $(patsubst %, modules/%.csv, $(MODULES))

all_modules: all_modules_owl #all_modules_obo
all_modules_owl: $(ALL_MODS_OWL)
all_modules_obo: $(patsubst %, modules/%.obo, $(MODS))


#Targets for ROBOT template modules
modules/SRPDIO_internal_vocab.owl: ../modules/SRPDIO_internal_vocab.csv
	$(ROBOT) template --template $< -i imports/ro_import.owl --prefix "SRPDIO:http://purl.obolibrary.org/obo/SRPDIO_" --ontology-iri "http://purl.obolibrary.org/srpdio/modules/SRPDIO_internal_vocab.owl" -o $@.tmp.owl && mv $@.tmp.owl $@
## TODO: move RO import out of here
## TODO: fix manual creation of chebi imports



	
