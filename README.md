# 1.0 The Predictive Performance Equation (PPE)
An application of PPE, a computational cognitive model, to the acquisition and retention of foreign language vocabulary

# 2.0 Description
The acquisition and retention of knowledge is impacted by at least three primary factors: 1. Amount of practice; 2. Elapsed time since practice; and 3. Temporal distribution of practice. PPE is a computational cognitive model of skill acquisition and retention. PPE is made up of a series of equations, implemented as a running computer simulation, that account for how amount of practice, elapsed time since practice occured, and the distribution of practice over time affects knowledge acquisition and retention.

The code in this repository applies PPE to a large, naturalistic dataset, the Second Language Acquisition Modeling (SLAM) dataset. The SLAM dataset contains over 2 million words and answers from over 6,000 students during their first 30 days of using Duolingo in 2018. Aside from providing a test of basic principles of memory and cognition, SLAM offers a unique opportunity to validate PPE using a diverse sample of individuals learning in naturalistic conditions.

# 3.0 Table of Contents
The src subdirectory contains two main files.

The first R Notebook, Descriptive_Analysis.rmd, presents a descriptive and statistical analysis of a subset of the SLAM data.
The second R Notebook, Cognitive_Model.rmd, fits PPE to a susbet of the SLAM data and displays the model fits.

The notebooks call functions contained in the utilities subdirectory, and they read and write to the inputs subdirectory.

# 4.0 Running the Simulation
To run the descriptive analysis, select the R Notebook, Descriptive_Analysis.rmd.
To run the cognitive model, select the R Notebook, Cognitive_Model.rmd.

This work was developed in R version 3.6.3 and uses several packages installed from CRAN: tidyverse; RColorBrewer; patchwork; dplyr; data.table; and parallel

# 5.0 Citations
Walsh, M. M., Gluck, K. A., Gunzelmann, G., Jastrzembski, T., & Krusmark, M. (2018). Evaluating the theoretic adequacy and applied potential of computational models of the spacing effect. Cognitive science, 42, 644-691.

Settles, Burr, 2018, "Data for the 2018 Duolingo Shared Task on Second Language Acquisition Modeling (SLAM)", https://doi.org/10.7910/DVN/8SWHNO, Harvard Dataverse, V4. 
