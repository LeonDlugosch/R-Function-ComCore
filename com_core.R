ComCore = function(df, groups, input = "abundance", min = 0.01, output = "plot"){
  if(all(rownames(installed.packages()) != "venn")== TRUE){install.packages("venn")}
  # Transforming data to absence/presence matrix using 'min' as threshold
  if(input == "abundance"){
    if(colSums(df)[1] == 1){df = df*100}
    df.ab = ifelse(df > min, 1, 0)
  }
  if(input == "count"){
    df = normalize_100(df)
    df.ab = ifelse(df > min, 1, 0)
  }
  f.levels = levels(as.groups(groups))
  # Conversion to grouped presence/absence matrix
  for(i in 1:length(f.levels)){
    if (i == 1){
      sum = as.data.frame(rowSums(df.ab[,which(groups == f.levels[i])]))
    }else{
      sum = as.data.frame(cbind(sum, rowSums(df.ab[,which(groups == f.levels[i])])))
    }
  } 
  
  names(sum) = f.levels
  sum.ab = as.data.frame(ifelse(sum >= 1, 1, 0))
  Group = "all"
  Count = summary(rowSums(sum.ab) == ncol(sum.ab))[3]
  
  for(i in 1:(ncol(sum.ab)-1)){
    combns = combn(1:ncol(sum.ab), i)
    # print(combns)
    df.temp = sum.ab[which(rowSums(sum.ab) == i),]
    
    for (j in 1:ncol(combns)){
      if(i == 1){
        Count = c(Count, summary(df.temp[,combns[,j]] == i)[3])
      }else{
        Count = c(Count, summary(rowSums(df.temp[,combns[,j]]) == i)[3])
      }
      # Group name generation
      for(k in 1:length(combns[,j])){
        if(k == 1){groups = names(sum.ab)[as.numeric(combns[k,j])]}else{
          groups = paste(groups, names(sum.ab)[as.numeric(combns[k,j])], sep = " + ")
        }
      }
      Group = c(Group, groups)
    }
  }
  res.df = data.frame(groups.Group = Group, Spec.count = as.numeric(Count))
  res.df[is.na(res.df)] = 0

  if(output == "plot"){
    for (i in 1:length(f.levels)){
      if(i == 1){venn.list = list()}
      venn.list[[i]] = assign(f.levels[i] , rownames(sum.ab[which(sum.ab[,i] == 1),]))
    }
    names(venn.list) = f.levels
    if(length(f.levels) > 3){ellipse = T}else{ellipse = F}
    venn(venn.list, ellipse = ellipse, zcolor = "style")
    print(res.df)
  }
  if(output == "table"){
    return(res.df)
  }
}

