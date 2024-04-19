classified_apps = df['Content Rating'].value_counts()

mature_17_index = classified_apps.index.get_loc('Mature 17+')

seventeen_occurrence_ratio = pd.DataFrame({
    'Content Rating': ['Mature 17+', 'Outras Classificações'],
    'Amount': [classified_apps[mature_17_index], (sum(classified_apps.values) - classified_apps.values[mature_17_index])]
})

percentages = [(val / classified_apps.sum()) * 100 for val in seventeen_occurrence_ratio['Amount']]
labels = [f"{label}\n{percentage:.1f}% ({amount})" for label, percentage, amount in zip(seventeen_occurrence_ratio['Content Rating'], percentages, seventeen_occurrence_ratio['Amount'])]

plt.figure(figsize=(13, 13))
plt.pie(seventeen_occurrence_ratio['Amount'], labels=labels)
plt.title('Frequência das Categorias')
plt.show()
