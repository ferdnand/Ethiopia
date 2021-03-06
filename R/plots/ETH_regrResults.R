setwd("~/GitHub/Ethiopia/")
source("R/setupFncns.r")

# price = read.csv('Analysis/priceShkWide.txt', skip = 1 , sep = '\t')

source("~/GitHub/Ethiopia/R/loadETHpanel.r")


data14 = data %>% 
  filter(year == 2014, ptrack == 2) 



# colors ------------------------------------------------------------------
colorAvg = '#e31a1c'
sizeAvg = 0.25
colorDot = '#353839' #'#525252'
colorAnnot = BuBr[2]
sizeDot = 3

width = 1.4
height = 1.3

widthBig = 1.723
heightBig = 1.3


# Infographic similar to fontawesome chart icon
fontawesome = data.frame(x = 1:20, y = c(1:8, seq(7,4, by = -1), 5:12))

ggplot(fontawesome, aes(x = x, y = y)) +
  geom_path(size = 0.8, colour = colorDot,
            arrow = arrow(length = unit(0.1,"cm"), type = 'closed')) +
  theme(aspect.ratio = 5/6) +
  theme_blankLH() +
  theme(axis.line = element_line(color = 'black', size = 0.15))

ggsave("~/GitHub/Ethiopia/R/plots/dummy_timeChart.pdf", 
       width = 0.6, height = 0.5,
       bg = 'transparent',
       paper = 'special',
       units = 'in',
       useDingbats=FALSE,
       compress = FALSE,
       scale = 1.25,
       dpi = 300)


# price: descriptive (not regression) -------------------------------------------------------------------


priceAvg14 = mean(data14$priceShk, na.rm = TRUE)

priceMax = 0.32


ggplot(data14, aes(x = wlthSmooth, y = priceShk)) +
  geom_hline(yint = priceAvg14, color = colorAvg, size = 0.5) +
  geom_smooth(fill = NA, size = 3) +
  coord_cartesian(xlim = c(0, 10), ylim = c(0, priceMax)) +
  theme_blankLH()
# stat_summary(fun.y = mean, geom  = 'line', size = 3)




# Price shocks v. education
# <<price_eduF_regr.pdf>>

s = ggplot(data14, aes(x = eduFcat, y = priceShk)) +
  geom_hline(yint = priceAvg14, color = colorAvg, size = sizeAvg) +
  coord_cartesian(xlim = c(0.6,4.4), ylim = c(0, priceMax)) +
  theme(aspect.ratio = height/width) +
  # scale_x_discrete(expand = c(0,0)) +
  # scale_y_continuous(expand = c(0,0)) +
  theme_blankLH() + 
  stat_summary(fun.y = mean, geom  = 'point', size = sizeDot, colour = colorDot) + 
  labs(x=NULL, y=NULL)


ggsave("~/GitHub/Ethiopia/R/plots/price_eduF_regr.pdf", plot = s,
       width = width, height = height,
       bg = 'white',
       paper = 'special',
       units = 'in',
       useDingbats=FALSE,
       compress = FALSE,
       dpi = 300)

# Religion
# <<price_relig_regr.pdf>>


q = ggplot(data14, aes(x = religHoh, y = priceShk)) +
  geom_hline(yint = priceAvg14, color = colorAvg, size = sizeAvg) +
  coord_cartesian(xlim = c(0.6,7.4), ylim = c(0, priceMax)) +
  theme(aspect.ratio = height/width) +
  # scale_x_discrete(expand = c(0,0)) +
  # scale_y_continuous(expand = c(0,0)) +
  theme_blankLH() + 
  stat_summary(fun.y = mean, geom  = 'point', size = sizeDot, colour = colorDot) + 
  labs(x=NULL, y=NULL)


ggsave("~/GitHub/Ethiopia/R/plots/price_relig_regr.pdf", plot = q,
       width = width, height = height,
       bg = 'white',
       paper = 'special',
       units = 'in',
       useDingbats=FALSE,
       compress = FALSE,
       dpi = 300)

ggplot(data14, aes(x = landQtile, y = priceShk)) +
  geom_hline(yint = priceAvg14, color = colorAvg, size = 0.5) +
  coord_cartesian(ylim = c(0, priceMax)) +
  theme_blankLH() + 
  stat_summary(fun.y = mean, geom  = 'line', size = 3)


# health: descriptive (not regression)  ------------------------------------------------------------------
healthAvg14 = mean(data14$healthShk, na.rm = TRUE)

healthMax = healthAvg14 + 0.03

ggplot(data14, aes(x = eduFcat, y = healthShk)) +
  geom_hline(yint = healthAvg14, color = colorAvg, size = sizeAvg) +
  coord_cartesian(xlim = c(0.6,4.4), ylim = c(0, healthMax)) +
  theme(aspect.ratio = height/width) +
  # scale_x_discrete(expand = c(0,0)) +
  # scale_y_continuous(expand = c(0,0)) +
  theme_blankLH() + 
  stat_summary(fun.y = mean, geom  = 'point', size = sizeDot, colour = colorDot) + 
  labs(x=NULL, y=NULL)


ggplot(data14, aes(x = ftfzone, y = healthShk)) +
  geom_hline(yint = healthAvg14, color = colorAvg, size = sizeAvg) +
  coord_cartesian(xlim = c(-0.4,1.4), ylim = c(0, healthMax)) +
  theme(aspect.ratio = height/width) +
  # scale_x_discrete(expand = c(0,0)) +
  # scale_y_continuous(expand = c(0,0)) +
  theme_blankLH() + 
  stat_summary(fun.y = mean, geom  = 'point', size = sizeDot, colour = colorDot) + 
  labs(x=NULL, y=NULL)

ggplot(data14, aes(x = marriedHoh, y = healthShk)) +
  geom_hline(yint = healthAvg14, color = colorAvg, size = sizeAvg) +
  coord_cartesian(xlim = c(-0.4,1.4), ylim = c(0, healthMax)) +
  theme(aspect.ratio = height/width) +
  # scale_x_discrete(expand = c(0,0)) +
  # scale_y_continuous(expand = c(0,0)) +
  theme_blankLH() + 
  stat_summary(fun.y = mean, geom  = 'point', size = sizeDot, colour = colorDot) + 
  labs(x=NULL, y=NULL)

library(scales)
ggplot(data14, aes(x = landQtile_lag, y = healthShk)) +
  geom_hline(yint = healthAvg14, color = colorAvg, size = sizeAvg) +
  coord_cartesian(xlim = c(-0.4,4.4), ylim = c(0, healthMax)) +
  theme(aspect.ratio = height/width) +
  # scale_x_continuous(trans=log2_trans()) +
  # scale_x_discrete(expand = c(0,0)) +
  # scale_y_continuous(expand = c(0,0)) +
  theme_blankLH() + 
  stat_summary(fun.y = mean, geom  = 'point', size = sizeDot, colour = colorDot) + 
  stat_smooth(method = "loess", alpha = 0.00, size = 0.5, span = 1, color = colorDot) +  
  labs(x=NULL, y=NULL)



ggplot(data14, aes(x = dist_market, y = healthShk)) +
  geom_hline(yint = healthAvg14, color = colorAvg, size = sizeAvg) +
  # coord_cartesian(xlim = c(-0.4,1.4), ylim = c(0, healthMax)) +
  theme(aspect.ratio = height/width) +
  # scale_x_discrete(expand = c(0,0)) +
  # scale_y_continuous(expand = c(0,0)) +
  theme_blankLH() + 
  stat_smooth()+
  # stat_summary(fun.y = mean, geom  = 'point', size = sizeDot, colour = colorDot) + 
  labs(x=NULL, y=NULL)


# hazard: descriptive (not regression)  ------------------------------------------------------------------
hazardAvg14 = mean(data14$hazardShk, na.rm = TRUE)

hazardMax = hazardAvg14 + 0.47
xMaxTLU = 45


# << ETH_hazard_TLU_draft.pdf >>

ggplot(data, aes(x = TLUtotal_cnsrd_lag, y = hazardShk)) +
  geom_hline(yint = hazardAvg14, color = colorAvg, size = sizeAvg) +
  coord_cartesian(xlim= c(0, xMaxTLU), ylim = c(0, hazardMax)) +
  # scale_x_discrete(expand = c(0,0)) +
  # scale_y_continuous(expand = c(0,0)) +
  theme_xOnly() +
  theme(axis.line = element_blank(),
        axis.ticks.x = element_blank(),
        axis.text = element_blank(),
        aspect.ratio = heightBig/widthBig,
        axis.title.x = element_text(size = 6)) +
  stat_smooth(method = "loess", alpha = 0.00, size = 0.5, span = 1, color = colorDot)+
  annotate('rect', fill = BuBr[20], alpha = 0.2, 
           xmin = 0, xmax = xMaxTLU, ymin = hazardAvg14, ymax = hazardMax) +
  annotate('text', colour = BuBr[20], size = 2.5, label = 'more likely', hjust = 1,
           x = xMaxTLU - 6, y = (hazardMax - hazardAvg14)/2 + hazardAvg14) +
  annotate('rect', fill = colorAnnot, alpha = 0.2, 
           xmin = 0, xmax = xMaxTLU, ymin = 0, ymax = hazardAvg14) +
  annotate('text', colour = colorAnnot, size = 2.5, label = 'less likely', hjust = 1,
           x = xMaxTLU - 6, y = hazardAvg14/2) +
  annotate('text', colour = colorAvg, size = 2.5, label = 'average', hjust = 1,
           x = xMaxTLU - 6, y = hazardAvg14 + 0.02) +
  # stat_summary(fun.y = mean, geom  = 'point', size = sizeDot, colour = colorDot) + 
  labs(x="tropical livestock units", y=NULL)

ggsave("~/GitHub/Ethiopia/R/plots/ETH_hazard_TLU_draft.pdf", 
       width = widthBig, height = heightBig,
       bg = 'transparent',
       paper = 'special',
       units = 'in',
       useDingbats=FALSE,
       compress = FALSE,
       dpi = 300)


# << ETH_hazard_wealth_draft.pdf >>
ggplot(data14, aes(x = wlthSmooth, y = hazardShk)) +
  geom_hline(yint = hazardAvg14, color = colorAvg, size = sizeAvg) +
  coord_cartesian(xlim = c(1, 10), ylim = c(0, hazardMax)) +
  theme_xOnly() + 
  # stat_summary(fun.y = mean, geom  = 'point', size = sizeDot, colour = colorDot) + 
  theme(axis.line = element_blank(),
        axis.ticks.x = element_blank(),
        axis.text = element_blank(),
        aspect.ratio = heightBig/widthBig,
        axis.title.x = element_text(size = 6)) +
  stat_smooth(method = "loess", alpha = 0.00, size = 0.5, span = 1, color = colorDot)+
  annotate('rect', fill = BuBr[20], alpha = 0.2, 
           xmin = 1, xmax = 10, ymin = hazardAvg14, ymax = hazardMax) +
  annotate('text', colour = BuBr[20], size = 2.5, label = 'more likely', hjust = 1,
           x = 9, y = (hazardMax - hazardAvg14)/2 + hazardAvg14) +
  annotate('rect', fill = colorAnnot, alpha = 0.2, 
           xmin = 1, xmax = 10, ymin = 0, ymax = hazardAvg14) +
  annotate('text', colour = colorAnnot, size = 2.5, label = 'less likely', hjust = 1,
           x = 9, y = hazardAvg14/2) +
  annotate('text', colour = colorAvg, size = 2.5, label = 'average', hjust = 1,
           x = 9, y = hazardAvg14 + 0.02) +
  # stat_summary(fun.y = mean, geom  = 'point', size = sizeDot, colour = colorDot) + 
  labs(x="wealth", y=NULL)

ggsave("~/GitHub/Ethiopia/R/plots/ETH_hazard_wealth_draft.pdf", 
       width = widthBig, height = heightBig,
       bg = 'transparent',
       paper = 'special',
       units = 'in',
       useDingbats=FALSE,
       compress = FALSE,
       dpi = 300)




# price: regression coefficients ------------------------------------------------------------------
# << Eth_price_eduF_regr.pdf >>
priceRegrRaw = read.csv("~/GitHub/Ethiopia/Analysis/priceShkWide.csv",
                        stringsAsFactors = FALSE)

rowsEdu = 16:18

priceRegr = data.frame(xVal = 1:3, 
                       type = str_to_lower(priceRegrRaw$X[rowsEdu]), 
                       yVal = priceRegrRaw$b.4[rowsEdu],
                       se = as.numeric(as.character(priceRegrRaw$se.4[rowsEdu])))

confidFactor = data.frame(`0.9` = 1.645, `0.95` = 1.96, `0.98` = 2.33, `0.99` = 2.575)
# if (confidLevel == 0.95) {
#   confidFactor = 1.96
# }  else if (confidLevel == 0.9) {
#   confidFactor = 1.645
# } else if (confidLevel == 0.98) {
#   confidFactor = 2.33
# } else if (confidLevel == 0.99) {
#   confidFactor = 2.575
# }

priceRegr = priceRegr %>% 
  mutate(ci = se * confidFactor$X0.9)




plumbPlot = function(data,
                     baseline,
                     colorDot = '#353839',
                     sizeDot = 2.8,
                     sizeCI = 0.75,
                     colorAnnot = BuBr[2], 
                     sizeAnnot = 2,
                     sizePlumbLine = 0.06,
                     yLim = NA){
  
  if (is.na(yLim)) {
    yLim = c(min(data$yVal - data$ci), max(data$yVal + data$ci))
  }
  
  ggplot(data, aes(y = yVal, x = xVal)) +
    
    # -- Set themes --
    theme_blankLH() + 
    theme(aspect.ratio = height/width) +
    coord_cartesian(xlim = c(0.5, 3.5), ylim = yLim) +
    
    # -- Plumb line --
    geom_segment(aes(x = xVal, xend = xVal, y = 0,  yend = yVal), 
                 colour = colorDot, size = sizePlumbLine) +
    
    # -- CI bars @ CI --
    #     geom_linerange(aes(x = xVal, ymin = yVal - ci, ymax = yVal + ci), 
    #                    colour = colorAnnot, alpha = 0.2, size = sizeCI) +
    
    geom_rect(aes(xmin = xVal - 0.035, xmax = xVal + 0.035,
                  ymin = yVal - ci, ymax = yVal + ci), 
              colour = NA, fill = 'grey',
              alpha = 0.3) +
    
    # -- Point for magnitude of change --
    geom_point(size  = sizeDot, colour = colorDot) +
    
    
    # -- Annotation: baseline --
    geom_hline(yint = 0, colour = colorAvg, size = 0.2) +
    annotate(geom = 'text', label = baseline,  y = 0.005, x = 2, 
             color = colorAvg, hjust = 0.5, size = sizeAnnot) +
    
    # -- Annotation: % difference --
    geom_text(aes(label = paste0(percent(-yVal), ' points'),  
                  x = xVal + .12, y = yVal / 2), 
              color = colorAnnot, hjust = 0, size = sizeAnnot) +
    
    # -- Anotation: category type
    geom_text(aes(label = type,  
                  x = xVal - 0.12, y = yVal), 
              color = colorAnnot, hjust = 1, size = sizeAnnot)
}

plumbPlot(priceRegr,  baseline = 'no female education', yLim = c(-0.165, 0.115))

ggsave("~/GitHub/Ethiopia/R/plots/Eth_price_eduF_regr.pdf",
       width = width, height = height + 0.3,
       bg = 'white',
       paper = 'special',
       units = 'in',
       useDingbats=FALSE,
       compress = FALSE,
       dpi = 300)


# price: religion ------------------------------------------------------------------

priceRegrRaw = read.csv("~/GitHub/Ethiopia/Analysis/priceShkWide.csv",
                        stringsAsFactors = FALSE)

rowsRelig = 7:8

priceRegr = data.frame(xVal = 1:2, 
                       type = priceRegrRaw$X[rowsRelig], 
                       yVal = priceRegrRaw$b.4[rowsRelig],
                       se = as.numeric(as.character(priceRegrRaw$se.4[rowsRelig])))


# if (confidLevel == 0.95) {
#   confidFactor = 1.96
# }  else if (confidLevel == 0.9) {
#   confidFactor = 1.645
# } else if (confidLevel == 0.98) {
#   confidFactor = 2.33
# } else if (confidLevel == 0.99) {
#   confidFactor = 2.575
# }



priceRegr = priceRegr %>% 
  mutate(ci = se * confidFactor$X0.9)


plumbPlot(priceRegr,  baseline = 'Orthodox religion', yLim = c(-0.165, 0.115))

ggsave("~/GitHub/Ethiopia/R/plots/Eth_price_relig_regr.pdf",
       width = width, height = height+ 0.3,
       bg = 'white',
       paper = 'special',
       units = 'in',
       useDingbats=FALSE,
       compress = FALSE,
       dpi = 300)


# health regression: regional variation -----------------------------------
grey = '#979e9e'
blue =  "#0B0B8C"
brown = "#49221F"
greyBlue = colorRamp(c(grey, blue), space = 'Lab')
greyBrown= colorRamp(c(grey, brown), space = 'Lab')


healthRegrRaw = read.table("~/GitHub/Ethiopia/Analysis/healthShkWide.csv",
                           header = TRUE,
                           sep = ',',
                           stringsAsFactors = FALSE)

rowsRegion = 30:40

healthRegr = data.frame(type = str_to_lower(healthRegrRaw$X[rowsRegion]), 
                        yVal = healthRegrRaw$b.4[rowsRegion]) %>% 
  mutate(yVal = yVal / min(yVal))

colors = round(greyBlue(healthRegr$yVal),0)

colorsBr = round(greyBrown(-healthRegr$yVal),0)

row.names(colors) = healthRegr$type
row.names(colorsBr) = healthRegr$type

# health regression: male education ---------------------------------------
# << Eth_health_eduM_regr.pdf >>

healthRegrRaw = read.table("~/GitHub/Ethiopia/Analysis/healthShkWide.csv",
                           header = TRUE,
                           sep = ',',
                           stringsAsFactors = FALSE)

rowsEdu = 12:14

healthRegr = data.frame(xVal = 1:3, 
                        type = str_to_lower(healthRegrRaw$X[rowsEdu]), 
                        yVal = healthRegrRaw$b.4[rowsEdu],
                        se = as.numeric(as.character(healthRegrRaw$se.4[rowsEdu])))


healthRegr = healthRegr %>% 
  mutate(ci = 1.96 * se)


plumbPlot(healthRegr, baseline = 'no male education')



ggsave("~/GitHub/Ethiopia/R/plots/Eth_health_eduM_regr.pdf",
       width = width, height = height,
       bg = 'white',
       paper = 'special',
       units = 'in',
       useDingbats=FALSE,
       compress = FALSE,
       dpi = 300)


# health regression: land ---------------------------------------
# << Eth_health_eduM_regr.pdf >>

healthRegrRaw = read.table("~/GitHub/Ethiopia/Analysis/healthShkWide.csv",
                           header = TRUE,
                           sep = ',',
                           stringsAsFactors = FALSE)

rowsLand = 51:53

healthRegr = data.frame(xVal = 1:3, 
                        type = str_to_lower(healthRegrRaw$X[rowsLand]), 
                        yVal = healthRegrRaw$b.4[rowsLand],
                        se = as.numeric(as.character(healthRegrRaw$se.4[rowsLand])))


healthRegr = healthRegr %>% 
  mutate(ci = 1.96 * se)


plumbPlot(healthRegr, baseline = 'highest land ownership')



ggsave("~/GitHub/Ethiopia/R/plots/Eth_health_eduM_regr.pdf",
       width = width, height = height,
       bg = 'white',
       paper = 'special',
       units = 'in',
       useDingbats=FALSE,
       compress = FALSE,
       dpi = 300)

# dietary diversity regression: education (M+F) ---------------------------
colorMale = '#27aae1'
colorFemale = '#E37686'
xOffset = 0.25

ddRegrRaw = read.csv("~/GitHub/Ethiopia/Analysis/dietDivWide.csv",
                        stringsAsFactors = FALSE)

rowsEdu = 14:20

ddRegr = data.frame(xVal = 1:7, 
                       type = str_to_lower(ddRegrRaw$X[rowsEdu]), 
                       yVal = ddRegrRaw$b.4[rowsEdu],
                       se = as.numeric(as.character(ddRegrRaw$se.4[rowsEdu]))) %>% 
  slice(-4)


# if (confidLevel == 0.95) {
#   confidFactor = 1.96
# }  else if (confidLevel == 0.9) {
#   confidFactor = 1.645
# } else if (confidLevel == 0.98) {
#   confidFactor = 2.33
# } else if (confidLevel == 0.99) {
#   confidFactor = 2.575
# }

ddRegr = ddRegr %>% 
  mutate(ci = se * 1.96,
         sex = c('m', 'm', 'm',
                 'f', 'f', 'f'),
         xVal = c(1:3, 1 + xOffset, 2 + xOffset, 3+ xOffset))


plumb2Plot = function(data,
                     baseline,
                     colorDot = '#353839',
                     sizeDot = 2.8,
                     sizeCI = 0.75,
                     colorAnnot = BuBr[2], 
                     sizeAnnot = 2,
                     sizePlumbLine = 0.06){
  
  
  
  ggplot(data, aes(y = yVal, x = xVal, colour = sex)) +
    
    # -- Set themes --
    theme_blankLH() + 
    theme(aspect.ratio = height/width) +
    coord_cartesian(xlim = c(0.5, 3.5)) +
    
    # -- Plumb line --
    geom_segment(aes(x = xVal, xend = xVal, y = 0,  yend = yVal), 
                  size = sizePlumbLine, colour = colorDot) +
    
    # -- CI bars @ CI --
    #     geom_linerange(aes(x = xVal, ymin = yVal - ci, ymax = yVal + ci), 
    #                    colour = colorAnnot, alpha = 0.2, size = sizeCI) +
    
    geom_rect(aes(xmin = xVal - 0.035, xmax = xVal + 0.035,
                  ymin = yVal - ci, ymax = yVal + ci), 
              colour = NA, fill = 'grey',
              alpha = 0.3) +
    
    # -- Point for magnitude of change --
    geom_point(size  = sizeDot) +
    scale_color_manual(values  = c(colorFemale, colorMale)) +
    
    
    # -- Annotation: baseline --
    geom_hline(yint = 0, colour = colorAvg, size = 0.2) +
    annotate(geom = 'text', label = baseline,  y = 0.005, x = 2, 
             color = colorAvg, hjust = 0.5, size = sizeAnnot) +
    
    # -- Annotation: % difference --
    geom_text(aes(label = paste0(round(yVal,1)),  
                  x = xVal, y = yVal + ci + 0.1), 
              color = colorAnnot, hjust = 0.5, size = sizeAnnot) +
    
    # -- Anotation: category type
    geom_text(aes(label = type,  
                  x = xVal - 0.12, y = yVal), 
              color = colorAnnot, hjust = 1, size = sizeAnnot)
}

plumb2Plot(ddRegr,  baseline = 'no education')


ggsave("~/GitHub/Ethiopia/R/plots/Eth_dd_edu_regr.pdf",
       width = width, height = height,
       bg = 'white',
       paper = 'special',
       units = 'in',
       useDingbats=FALSE,
       compress = FALSE,
       dpi = 300)

