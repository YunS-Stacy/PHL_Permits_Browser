# Philadelphia Permits Browser

=======
## Install

```
# install.packages("shiny")
# install.packages("shinydashboard")
# install.packages("dplyr")
# install.packages("leaflet")
# install.packages("ggplot2")
# install.packages("lubridate")

shiny::runGitHub("YunS-Stacy/PHL_Permits_Browser")
```

This application is an example of a dashboard that can be quickly prototyped
and deployed in order to visualize permits in Philadelphia City. The dashboard
includes the following features:

1. An interactive map of Philadelphia including:
  - Clustered permits events
  - Popup text for each event with permits details
2. Widgets that provide aggregate summaries of permits events.
3. A calendar that allows the user to filter permits events by date. This calendar
is consistent throughout the app.
4. Vizualizations of permits over time and by type of permits.

The following R Packages were used to prepare the data for this app:

- dplyr
- lubridate
- readr
- magrittr
- stringr
- purrr

The following R Packages are used to render this app:

- shiny
- shinydashboard
- dplyr
- leaflet
- ggplot2
- lubridate

To run this app locally make sure you've installed the R packages mentioned above, then
run:

```
shiny::runGitHub("YunS-Stacy/PHL_Permits_Browser")
```
