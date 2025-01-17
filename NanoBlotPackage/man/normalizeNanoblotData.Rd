% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/normalizeNanoblot.R
\name{normalizeNanoblotData}
\alias{normalizeNanoblotData}
\title{Normalizes Nanoblot data}
\usage{
normalizeNanoblotData(
  nanoblotData,
  normalizationType = "differential",
  unnormalizedFiles,
  annotationFile = NA,
  coldata = NULL,
  writeOutFile = NULL
)
}
\arguments{
\item{nanoblotData}{This is a data frame that is generated from bamFilesToNanoblotData}

\item{normalizationType}{This is the type of normalization, either 'differential' or 'size'. DEFAULT is 'differential'}

\item{unnormalizedFiles}{This is a vector that contains the string file locations of all the samples in nanoblotData.}

\item{annotationFile}{This is a gtf file obtained from a database that contains the organism of interest's genomic annotations.
This is only needed for the 'differential' normalization method}

\item{coldata}{This is a DeSeq2 coldata argument that is called with the DeSeq2 function DESeqDataSetFromMatrix}

\item{writeOutFile}{This is the write out file for DeSeq2 if the user specifies, NULL by default}
}
\description{
This function is used to generate size factors for Nanoblot data normalization. The user can specify two
types of normalization, either 'differential' which uses DeSeq2 normlization or 'size' which uses a library size normalization
method for sequencing data that is not based off of previously annotated genomic regions
}
\examples{
TestDataNames <- c("WT_RPL18A", "RRP6_RPL18A")
TestDataFiles <- c("./temp/WT_RPL18A_Exon1.bam", "./temp/RRP6_RPL18A_Exon1.bam")
unnormalizedLocations <- c("./data/example/WT_sorted_merged.bam", "./data/example/RRP6_sorted_merged.bam")

BamsWTRRP6 <- scanBamFiles(TestDataNames, TestDataFiles)
NanoblotDataWTRRP6 <- bamFilesToNanoblotData(BamsWTRRP6)
size_factors <- calculateDESeqSizeFactors(NanoblotDataWTRRP6, normalizationType = 'size', unnormalizedLocations)

returns a vector with 2 elements of data type containing only whole numbers
}
