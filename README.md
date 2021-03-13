# Modeling _Plasmodium falciparum_ Diagnostic Test Sensitivity using Machine Learning with Histidine-Rich Protein 2 Variants

<h3 align = "right">Colby T. Ford, Gezahegn Alemayehu,<br>Kayla Blackburn, Karen Lopez, Cheikh Cambel Dieng,<br>Eugenia Lo, Lemu Golassa, and Daniel Janies</h3>

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

## Abstract
Malaria, predominantly caused by _Plasmodium falciparum_, poses one of largest and most durable health threats in the world. Previously, simplistic regression-based models have been created to characterize malaria infections, though these models often only include a couple genetic factors. Specifically, the Baker et al., 2005 model uses two types of particular repeats in histidine-rich protein 2 (PfHRP2) to assert _P. falciparum_ infection, though the efficacy of this model has waned over recent years due to genetic mutations in the parasite.

In this work, we use a dataset of 406 _P. falciparum_ PfHRP2 genetic sequences collected in Ethiopia and derived a larger set of motif repeat matches for use in generating a series of diagnostic machine learning models. Here we show that the usage of additional and different motif repeats proves effective in predicting infection. Furthermore, we use machine learning model explanability methods to highlight which of the repeat types are most important, thereby suggesting potential targets for future versions of rapid diagnostic tests.

## Important Supplementary Data
- Model metrics for all trained models are in the [/models](/models) folder. Note: The top performaing models' .pkl files are also available.
- PfHRP2 sample sequences, motif matches, and metadata are available in the [pfHRP2_withMeta.csv](pfHRP2_withMeta.csv) file.
- The histidine-based motif repeat finder is provided in the [H_motif_finder.R](H_motif_finder.R) R script.
