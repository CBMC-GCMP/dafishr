---
title: 'dafishr: An R Package to Download, Wrangle, and Analyze Vessel Monitoring System Data'
tags:
  - fishery
  - IUU fishing
  - mixture models
  - marine protected areas
  - marine conservation
authors:
  - name: Fabio Favoretto
    orcid: 0000-0002-6493-4254
    equal-contrib: true
    affiliation: "1, 2" # (Multiple affiliations must be quoted)
affiliations:
 - name: Scripps Institution of Oceanography, University of California San Diego, La Jolla, CA, USA
   index: 1
 - name: Centro para la Biodiversidad y la Conservacion, A.C., La Paz, Baja California Sur, Mexico
   index: 2
date: 2 December 2022
bibliography: paper.bib
editor_options: 
  markdown: 
    wrap: 72
---

# Summary

Illegal, Unreported, and Unregulated catches, commonly known as IUU
fishing, are a big socio-economic problem with worldwide implications
[@iuufish2021]. Making fishing vessels information available to
researchers is critical in understanding how to stop and deter IUU
activities. Here, I provide a novel tool to download, wrangle, and
analyze Vessel Monitoring System (VMS) data from the Mexican fishing
industry. VMS data are hourly pings of geolocations of each of the 2000
(roughly) industrial vessels active under a Mexican flag. Data can be
downloaded from 2007 to 2022, and new data is uploaded with a two-month
delay in the <https://datos.gob.mx/> initiative portal. The package
eliminates the need to download the data manually as these can be
automatically searched and downloaded. Data comes in a directory labeled
by year, so only bulk download is available up to now. Once downloaded,
data can be easily wrangled into a tidy format [@wickham2014;
@baumer2021]. The preprocessing coded within our package allows us to
correct or filter out several data inconsistencies and spatially relates
the vessels positions to specific locations. For example, all data will
be intersected with the layer of all marine protected areas in Mexico,
exclusive economic zone, and port areas. Finally, data can be modeled
using Gaussian Mixture Models that are fitted to speed values
[@mixtools]. Usually, an industrial boat at sea maintains a constant
cruise speed, whereas, if that speed is not maintained, some activity is
undertaken by the crew. If port areas are excluded, diverging from
cruise speed in the high seas is likely because of preparation for
fishing activity. Thanks to these model outputs, one can infer potential
fishing grounds from these models and gather more insights from these
labeled data.

# Statement of need

[`dafishr`](https://cbmc-gcmp.github.io/dafishr/) is a package addressed
to the fishery and marine conservation scientists. Despite being
specific to the VMS dataset from the Mexican fishing industry, it can
have a more extensive application. VMS data are rarely available and, if
they are available, often take more time and effort to work with.
Therefore, even if data is available to download, it still needs to be
discovered or accessed by most researchers. Our package aims to bridge
that gap by making the VMS data more usable and available for further
analysis and work. Furthermore, output data can be used to assess
regional fishing impacts; assess marine protected areas' efficiency in
deterring fishing activity, and create models that can generate useful
information for the fishing industry to make them more efficient.

# Acknowledgements

I acknowledge contributions from Eduardo Leon Solorzano, and support
from the Patrick J. McGovern Foundation. This package enabled the
analysis that is featured in a manuscript currently under review for
publication in a peer reviewed journal [@favoretto2022].

# References
