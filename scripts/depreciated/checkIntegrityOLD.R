calculateIntegrity <- function(GeneTargets, BamFiles) {
  GRanFilter <- Rsamtools::ScanBamParam(which = GeneTargets)
  totalCounts <- Rsamtools::countBam(file = BamFiles, param = GRanFilter)
  
  GRanFilterEnds <- Rsamtools::ScanBamParam(what = c("pos","cigar"),which = GeneTargets )
  PosList <- lapply(BamFiles, Rsamtools::scanBam, param = GRanFilterEnds)
  ReadsEnding <- c()
  for (SampleNum in seq_along(PosList)) {
    for (RangeNum in seq_along(PosList[[SampleNum]])){
      StartPos <- PosList[[SampleNum]][[RangeNum]][["pos"]]
      RefWidth <- GenomicAlignments::cigarWidthAlongReferenceSpace(PosList[[SampleNum]][[RangeNum]][["cigar"]])
      EndPos <- StartPos + RefWidth
      
      GranStart <- GeneTargets@ranges@start[RangeNum]
      GranEnd <-GranStart + GeneTargets@ranges@width[RangeNum]
      if (identical(as.vector(GeneTargets@strand[RangeNum]),"-")) {
        PosList[[SampleNum]][[RangeNum]]$EndsWithin <- (EndPos > GranStart & EndPos < GranEnd)
      } else if (identical(as.vector(GeneTargets@strand[RangeNum]),"+")) {
        PosList[[SampleNum]][[RangeNum]]$EndsWithin <- (StartPos > GranStart & StartPos < GranEnd)
      }
      ReadsEnding <- c(ReadsEnding, sum(PosList[[SampleNum]][[RangeNum]]$EndsWithin))
    }
  }
  totalCounts$FivePrimeEnds <- ReadsEnding
  totalCounts$ReadEndsInRegion <- (totalCounts$FivePrimeEnds/totalCounts$records)*100
  totalCounts$file <- as.factor(totalCounts$file)
  
  plotoutput <- ggplot2::ggplot(data = totalCounts)+
    ggplot2::geom_point(ggplot2::aes(x=width,y=ReadEndsInRegion, colour=file))
  
  print(plotoutput)
  return(totalCounts)
}
