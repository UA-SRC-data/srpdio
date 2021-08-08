This folder contains the source CSV files used to build Robot modules.

THere are also OWL files here, but the output of module generation should be ../ontology/modules, so I am not sure if these files are needed.

# Socio-economic variabls (SE)
We are using a number of socio-economic varibles to understand vulnerabilities and resilience. They come from both ACS5 and EJS.

## Methods for creating ontology classes 

D. Kaufman and M. Ramirez-Andreotta reviewed all data available from EJS and ACS5 and selected variables that were important to our study. This resulted in a list of variables at https://github.com/UA-SRC-data/data_loaders/blob/master/acs5/acs_variables_to_download.csv and https://github.com/UA-SRC-data/data_loaders/blob/master/ejscreen/ejs_traits.csv. Note: Not all varibles in those lists are being used. 

Kaufman created an initial categorization of the variables for both EJS and ACS5, in which specific variables for this study were chosen. 

R. Walls used the initial categorization to gather all of the required variable into googl sheets at https://drive.google.com/drive/folders/1npFP_tMnzAGkPP_QtXoTEitbDj4mCbMW?usp=sharing. She then used the text to columns function to break each variable into its component parts, which are categorical variables (see ACS5, below). She manually specified what the root quality for each ACS5 variable was (e.g, number of people, per capita income in the past 12 months (in 2018 inflation-adjusted dollars)). Root qualities are continuous or count variables. Walls manually created csv files with the root qualities and categorical qualities from both ACS and EJS:
- `se_root_variables.csv`
- `se_qualifier_variables.csv`

Walls then manually manipulated these sheets to make separate files for each module, as described below.

## Root (data) variables/measurement data module (ACS and EJS)
The data variablees are what is actually being measured, that is numerical data that have values, including:
- number of people
- per capita income in the past 12 months (in 2018 inflation-adjusted dollars)
- etc.

Classes for the root variables are subclass of 
- http://purl.obolibrary.org/obo/STATO_0000047 count
- http://purl.obolibrary.org/obo/OMRSE_00000501 income data
- UO:0000187 percent
- IAO:0000109 measurement datum

The variables in `se_root_variables.csv` were organized and expanded to create `se_data_classes.csv` file is used to create a module with classes for information content entities from both EJS and ACS5. The module is stored in src/ontology/modules/se_data_classes.owl

## EJS module

We are using a few dozen variables from the US EPA's Environmental Justice Screening tool (EJS). These variables are not complex like ACS5, so classes for them are simply being added in the robot module for root variable (above).

## ACS5 module for categories

The American Community Survey (ACS5) contains thousands of variables, of which we are using hundreds. With a few exceptions (e.g., per capita income) these variables are counts of people per area (census block group in our casee). See Root variables, above. 

The counts are categorized by combinations of multipe factors. For example, under "POVERTY STATUS IN THE PAST 12 MONTHS OF INDIVIDUALS BY SEX BY EMPLOYMENT STATUS", there is a specific variable (B17005_004E) that is the number of people per census block group who have income in the past 12 months below poverty level, are male, and are in labor force (Estimate!!Total!!Income in the past 12 months below poverty level!!Male!!In labor force).

We treat these factors as categorical qualities, subclasse of PATO:quality. We first made or imported classes for each axis of variation. For example, there is a quality "labor force status" with sub-classes "in labor force" and "not in labor force". Likewise, there is a quality "race or ethnicity" with subclasses for each of the categories used by ACS5 (e.g., WHITE ALONE HOUSEHOLDER, BLACK OR AFRICAN AMERICAN ALONE HOUSEHOLDER, AMERICAN INDIAN AND ALASKA NATIVE ALONE HOUSEHOLDER). For sex, we imported "phenotypic sex" from PATO, with its suclasses for "male" and "female".

We also included some grouping categories, such as `age category`, `housing quality`, or `quality about a language spoken`. These grouping categories are used to logically define measurement datum classes that group together different data classes based on what they are about. This aids in browsing and searching.

## Final variables
The leaf nodes for all the variables are constructed using design patterns. See the readme file under src/pattern/acs5_variable_sheets
- 


