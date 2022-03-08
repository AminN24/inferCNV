#!/usr/bin/env Rscript

main = function(){

  args = commandArgs(trailingOnly=TRUE)

  if (length(args)==0) {
    stop("At least one argument must be supplied (input file).n", call.=FALSE)
  }

  count.dir = args[1]
  print(count.dir) # robust this with respect to cases with 1 gene.count file
  count.ids = list.files(path = count.dir)
  count.mat = read.table(file = paste0(count.dir,"/",count.ids[1]), sep = '\t')
  colnames(count.mat) = c("gene.id", "UMI.count")
  
  for(i in 2:length(count.ids)){
    temp.mat = read.table(file = paste0(count.dir,"/",count.ids[i]), sep = '\t')
    colnames(temp.mat) = c("gene.id", "UMI.count")
    count.mat = merge(x = count.mat, y = temp.mat, by = "gene.id", all = TRUE)
    print(count.ids[i])
  }

  colnames(count.mat) = c("gene.id", count.ids)
  write.table(x = count.mat, file = "UMI_count_matrix.tsv", col.names = TRUE, 
              row.names = FALSE, sep = "\t", na = ".")
}

main()
