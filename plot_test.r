library(ggplot2)
# 示例数据：包含基因、log2FoldChange 和 pValue
df <- data.frame(
  Gene = c("Gene1", "Gene2", "Gene3", "Gene4", "Gene5", "Gene6", "Gene7"),
  log2FoldChange = c(2.5, -1.8, 0.3, -2.2, 0.1, 4.1, -0.5),
  pValue = c(0.001, 0.05, 0.1, 0.0005, 0.8, 0.00001, 0.2)
)

# 计算 -log10(pValue)，用于显示在火山图中
df$negLog10P <- -log10(df$pValue)
# 创建火山图
ggplot(df, aes(x = log2FoldChange, y = negLog10P)) +
  geom_point(aes(color = pValue < 0.05 & abs(log2FoldChange) > 1), size = 3) +  # 根据 pValue 和 log2FoldChange 来设定显著性
  scale_color_manual(values = c("grey", "red")) +  # 非显著为灰色，显著的为红色
  labs(
    title = "Volcano Plot",
    x = "log2 Fold Change",
    y = "-log10(p-value)"
  ) +
  theme_minimal() +
  theme(
    legend.position = "none",
    plot.title = element_text(hjust = 0.5)
  )
# 保存为 PNG 图像
ggsave("volcano_plot.png", width = 8, height = 6)
