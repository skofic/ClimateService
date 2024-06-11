# Climate Service
Collection of scripts to generate EUFGIS external databases data.

This repository contains all the scripts used to generate *characterisation* and *environmental* data used by EUFGIS to characterise *forest genetic conservation units*.

- **Characterisation data**: FORGENIUS datasets providing genetic, modelled, phenotypic, forest and environmental datasets characterising european forest conservation units.
- **Chelsa**: Climate data from Chelsa, historical and future scenarios. Grid for extended Europe.
- **WorldClim**: Climate data from WorldClim, historical and future scenarios. Grid for extended Europe.
- **European Drought Observatory** (EDO): Grid for extended Europe.
    - *Combined Drought Indicator (CDI)*
    - *Fraction of Absorbed Photosynthetically Active Radiation (FAPAN) Anomaly*
    - *Fraction of Absorbed Photosynthetically Active Radiation (FAPAR)*
    - *Heat and Cold Wave Index (HCWI)*
    - *Soil Moisture Anomaly (SMA)*
    - *Soil Moisture Index (SMI)*
    - *GRACE Total Water Storage (TWS) Anomaly*
- **Satellite Remote Sensing**: Grid for extended Europe.
    - *CCI BIOMASS, 2010*
    - *Dominant Leaf Type, 2018*
    - *ERA5-Land Hourly*
    - *Global Forest Canopy Height, 2019*
    - *Terra Land Surface Temperature and Emissivity*
    - *Terra Leaf Area Index/FPAR*
    - *MODIS Combined 16-Day NDWI*
    - *Aqua Gross Primary Productivity*
    - *Sentinel-2 Multi-Spectral Instrument, Level-1C*

*The scripts have been used to load one run of data, however, with the experience gained in this first run we have decided to revise all scripts and produce a new version. This means that the current structure and code is expected to change in the future.*

## Database

The database holding all this data is ArangoDB. We chose this engine because it is a multi-model database, allowing us to use tables, key/values and graphs withous needing different engines.

## Geometries

There are three main ways of providing this data:

- *As a grid*. This mode will provide access to a multi-resolution set of grids covering Europe and neighbouring regions. Users will select one or more reference coordinates and the system will return the measurements matching all cells that contain those points.
    - **Chelsa**
    - **WorldClim**
    - **EDO**
- *Averaged over the surface of a shape*. This mode will provide averages for forest conservation unit (GCU) *polygons* and *multi-polygons*. The generation of this data is performed as a batch using the current list of geometries related to the EUFGIS GCUs. Each polygon or multi-polygon will have its set of time series data.
    - **Satellite Remote Sensing**
- *Free form*: In this mode the data itself contains eventual geographic references:
    - **Characterisation data**

## Operations

Currently the source is a set of command-line, AQL queries and GDAL scripts that are used to perform the following operations:

1. **Download the data**.
    The remote sensing data is generated in Google Earth Engine using a Python COLAB, other data is downloaded locally.
2. **Validate and normalise the data**.
    Validation involves eliminating no-data records, cropping geographic bounds to the area of interest, cleaning and generating one or more tables with the raw cleaned data.
3. **Aggregate data**.
    This step involves grouping individual data into a collection of data *following the guidelines and rules of the data dictionary (more on this later)*.
4. **Dump data into a database compatible format**.
    Datasets are formatted according to the desired structure. Each type of dataset using a structure to maximise the retrieval speed (*one dataset has over one billion records*).

## Standards

All descriptors used in the database have their metadata managed and stored in the data dictionary. This means that any database field has a related metadata entry in the dictionary, so all elements of the information system are documented. This is *enforced*, and also the descriptors constituting the dictionary are documented in the same way.

Check **[this](https://github.com/skofic/data-dictionary-management/blob/main/docs/README.md)** document for an overview of the data dictionary.

## Services

The data can be retrieved using a set of micro-services residing directly in the database:

- **Data Dictionary and Characterisation data**:
    - [Authentication services](https://github.com/skofic/authentication-services/blob/main/README.md)
    - [Data Dictionary Management](https://github.com/skofic/data-dictionary-service/blob/main/README.md)
    - [Characterisation Data](https://github.com/skofic/characterisation-database-service/blob/main/README.md)
- **External Databases**:
    - [Environmental Services](https://github.com/skofic/environmental-services/blob/main/README.md)

## Progress

This is a work in progress, learning from the past experience and building upon it.

We are not providing detailed explanations and instructions, because we plan to start formalising the process after the next data collection run that should occur by the end of this year.

*To be continued...*
