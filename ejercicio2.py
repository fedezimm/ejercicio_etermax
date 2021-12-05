import pandas as pd
import sys

args = sys.argv   

# The function deletes rows with any null value/s because the file comes with several
# corrupted rows
def transform_data(filepath='datos_data_engineer.tsv', output_file='datos_data_engineer_output_file.csv'):
    """The function takes a file_path, read the file, process it and then rewrite in the desired format"""
    print("parameter filepath: "+filepath+", parameter output_file= "+output_file)
    data = pd.read_csv(filepath,sep='\t',encoding='UTF-16LE').dropna(how='any')
    data.to_csv(output_file,sep='|',encoding='UTF-8',index=False)

transform_data(filepath=args[1], output_file=args[2])