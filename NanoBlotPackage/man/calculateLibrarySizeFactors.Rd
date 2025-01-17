% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/normalizeNanoblot.R
\name{calculateLibrarySizeFactors}
\alias{calculateLibrarySizeFactors}
\title{Calculate Normalization Size Factors for NanoBlot without annotation file}
\usage{
calculateLibrarySizeFactors(nanoblotData, unnormalizedFiles)
}
\arguments{
\item{nanoblotData}{This is a data frame that is generated from bamFilesToNanoblotData}

\item{unnormalizedFiles}{This is a vector that contains the string file locations of all the samples in nanoblotData}
}
\description{
This function is required to normalize Nanoblots using a counts per greatest common factor normalization method.
It is not meant to be used by the end user.
It does not use a GTF annotation file.
}
\examples{
TestDataNames <- c("WT_RPL18A", "RRP6_RPL18A")
TestDataFiles <- c("./temp/WT_RPL18A_Exon1.bam", "./temp/RRP6_RPL18A_Exon1.bam")
unnormalizedLocations <- c("./data/example/WT_sorted_merged.bam", "./data/example/RRP6_sorted_merged.bam")

BamsWTRRP6 <- scanBamFiles(TestDataNames, TestDataFiles)
NanoblotDataWTRRP6 <- bamFilesToNanoblotData(BamsWTRRP6)
calculateDESeqSizeFactors(NanoblotDataWTRRP6, unnormalizedLocations)

returns a vector with 2 elements
}
