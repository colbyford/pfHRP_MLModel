<h1 align="middle">Modeling <i>Plasmodium falciparum</i> Diagnostic Test Sensitivity using Machine Learning with Histidine-Rich Protein 2 Variants</h1>

<h3 align = "middle">Colby T. Ford, Gezahegn Solomon Alemayehu, Kayla Blackburn, Karen Lopez,<br>Cheikh Cambel Dieng, Eugenia Lo, Lemu Golassa, and Daniel Janies</h3>

## Abstract
Malaria, predominantly caused by _Plasmodium falciparum_, poses one of largest and most durable health threats in the world. Previously, simplistic regression-based models have been created to characterize malaria rapid diagnostic test performance, though these models often only include a couple genetic factors. Specifically, the Baker et al., 2005 model uses two types of particular repeats in histidine-rich protein 2 (PfHRP2) to describe a _P. falciparum_ infection, though the efficacy of this model has waned over recent years due to genetic mutations in the parasite.

In this work, we use a dataset of 100 _P. falciparum_ PfHRP2 genetic sequences collected in Ethiopia and derived a larger set of motif repeat matches for use in generating a series of diagnostic machine learning models. Here we show that the usage of additional and different motif repeats in more sophisticated machine learning methods proves effective in characterizing PfHRP2 diversity. Furthermore, we use machine learning model explainability methods to highlight which of the repeat types are most important with regards to rapid diagnostic test sensitivity, thereby showcasing a novel methodology for identifying potential targets for future versions of rapid diagnostic tests.


## Important Supplementary Data
- Model metrics for all trained models are in the [/models](/models) folder. Note: The top performing models' .pkl files are also available.
- PfHRP2 sample sequences, motif matches, and metadata are available in the [pfHRP2_withMeta.csv](pfHRP2_withMeta.csv) file.
- The histidine-based motif repeat finder is provided in the [H_motif_finder.R](H_motif_finder.R) R script.


-----------

## Paper and Citation

__Frontiers in Tropical Diseases:__ [frontiersin.org/articles/10.3389/fitd.2021.707313](https://www.frontiersin.org/articles/10.3389/fitd.2021.707313/full)

```
@article {Ford2021,
	author = {Ford, Colby T. and Alemayehu, Gezahegn Solomon and Blackburn, Kayla and Lopez, Karen and Dieng, Cheikh Cambel and Lo, Eugenia and Golassa, Lemu and Janies, Daniel},
	title = {Modeling Plasmodium falciparum Diagnostic Test Sensitivity using Machine Learning with Histidine-Rich Protein 2 Variants},
	publisher = {Frontiers},
	journal = {Frontiers in Tropical Diseases},
	volume = {2},
	pages = {28},
	month = {October},
	year = {2021},
	paper = {707313},
	doi = {10.3389/fitd.2021.707313},
	url = {https://www.frontiersin.org/article/10.3389/fitd.2021.707313},
	issn = {2673-7515}
	
}
```
<!--
__medRxiv Preprint:__ [medrxiv.org/content/10.1101/2020.05.27.20114785v2](https://www.medrxiv.org/content/10.1101/2020.05.27.20114785v2)

```
@article {Ford2020.05.27.20114785,
	author = {Ford, Colby T and Alemayehu, Gezahegn and Blackburn, Kayla and Lopez, Karen and Dieng, Cheikh Cambel and Lo, Eugenia and Golassa, Lemu and Janies, Daniel},
	title = {Modeling Plasmodium falciparum Diagnostic Test Sensitivity using Machine Learning with Histidine-Rich Protein 2 Variants},
	elocation-id = {2020.05.27.20114785},
	year = {2020},
	doi = {10.1101/2020.05.27.20114785},
	publisher = {Cold Spring Harbor Laboratory Press},
	URL = {https://www.medrxiv.org/content/early/2020/05/29/2020.05.27.20114785},
	eprint = {https://www.medrxiv.org/content/early/2020/05/29/2020.05.27.20114785.full.pdf},
	journal = {medRxiv}
}
```
-->
