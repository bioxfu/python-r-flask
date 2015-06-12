#! /usr/bin/env Rscript

install.packages(c(
"seqinr",
"caret",
"ROCR",
"randomForest"
), repos="http://mirrors.ustc.edu.cn/CRAN/")

source("http://bioconductor.org/biocLite.R")
biocLite(c("Biostrings"))

