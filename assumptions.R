
# Assumption 1: all recommendations given are necessary to prevent the death

recs <- c("A", "B", "C", "D", "E", "F", "G", "H", "I", "J")
combos <- unlist(lapply(1:10, function(n) {
  apply(combn(recs, n), 2, paste, collapse = "")
}))

prev.data <- data.frame()

for (i in combos) {
  x <- unlist(strsplit(i, split = ""))
  
  sub_combos <- unlist(lapply(1:length(x), function(n) {
    apply(combn(x, n), 2, paste, collapse = "")
  }))
  
  sum <- dat %>%
    filter(value %in% sub_combos) %>%
    group_by(age.cat) %>%
    summarise(tot = sum(n))
  
  if (nrow(sum) > 0) {
    prev.data.1 <- data.frame(prev = i, sum)
    prev.data <- rbind(prev.data, prev.data.1)
  }
}


# Assumption 2: deaths prevented relative to number of measures implemented

prev.data <- data.frame()

for (combo in combos) {
  x <- unlist(strsplit(combo, split = ""))
  
  tmp1 <- data %>%
    select(age.cat, prev.num, all_of(x)) %>%
    filter(nchar(prev.num) >= 1)
  
  if (length(x) == 1) {
    tmp1 <- tmp1 %>%
      mutate(saves = get(x) / nchar(prev.num))
  } else {
    tmp1 <- tmp1 %>%
      mutate(saves = rowSums(select(tmp1, all_of(x))) / nchar(prev.num))
  }
  
  tmp1 <- tmp1 %>%
    group_by(age.cat) %>%
    summarise(tot = sum(saves))
  
  prev_data <- bind_rows(prev_data, data.frame(prev = combo, tmp1))
}


# Assumption 3: any single category implemented among categories recommended is sufficient to prevent the death

for (combo in combos) {
  x <- unlist(strsplit(combo, split = ""))
  
  tmp1 <- data %>%
    select(age.cat, all_of(x))
  
  if (length(x) == 1) {
    tmp1 <- tmp1 %>%
      group_by(age.cat) %>%
      summarise(tot = sum(get(x)))
  } else {
    tmp1 <- tmp1 %>%
      mutate(any = rowSums(select(tmp1, all_of(x))) > 0) %>%
      group_by(age.cat) %>%
      summarise(tot = sum(any))
  }
  
  prev_data <- bind_rows(prev_data, data.frame(prev = combo, tmp1))
}



