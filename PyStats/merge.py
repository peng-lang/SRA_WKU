import os
import re
import xlwt
import xlrd
from datetime import date, datetime 

current_path = os.path.abspath(os.path.dirname(__file__))

def get_excel_files(path=current_path):
    raw_files = os.listdir(path)
    files = []
    for file in raw_files:
        if file.find('xls') >= 0:
           files.append(file)

    # print(raw_files)
    # print(files)
    if files == []:
        print("**Warning**: check if you entered right path")
        print("your path is: {}".format(path))

        
    return files

def translate_rawdata(raw_data):
    result = []
    # Use regular expression to check if float
    value = re.compile(r'^[-+]?[0-9]+\.[0-9]+$')
    for row in raw_data:
        trl_row = []
        for data in row:
            # length geater than 11, probablly it's a phone number or others
            if len(data.value) >= 11 or data.ctype == 1:
                trl_row.append(data.value)
            elif data.ctype == 2:
                if value.match(str(data.value)):
                    trl_row.append(float(data.value))
                else:
                    trl_row.append(int(data.value))
            else:
                trl_row.append(data.value)
        result.append(trl_row)
    return result

def read_excel(file, sRow=0, eRow=-1, sheet_index=0):
    wb = xlrd.open_workbook(filename=file, formatting_info=True)# Open Flle
    #print(wb.sheet_names())# Get names of all sheets 
    try:
        sheet = wb.sheet_by_index(sheet_index)# Get sheet by index
    except:
        return []
    raw_data = []
    for i in range(sheet.nrows):
        raw_data.append(sheet.row(i))
    data = translate_rawdata(raw_data)
    #print(data) 
    #print(sheet.name, sheet.nrows, sheet.ncols)
    
    return data[sRow:] if eRow == -1 else data[sRow:eRow]

# set excel style 
def set_style(name, height, bold=False):
    style = xlwt.XFStyle()
    font = xlwt.Font()
    font.name = name
    font.bold = bold
    font.color_index = 4
    font.height = height
    style.font = font
    return style

# Wirte Excel Spreadsheet
def write_excel(data, sheetName='Sheet1'):
    f = xlwt.Workbook()
    sheet = f.add_sheet(sheetName, cell_overwrite_ok=True)
    rows = data
    #print(range(len(rows)))
    #print(range(len(rows[0])))
    # write first column
    for i in range(len(rows)):
        for j in range(len(rows[i])):
            sheet.write(i, j, rows[i][j], set_style('Times New Roman', 220, True))
            #print(rows[i][j])
    sheet.write_merge(0,0,0,len(rows[0])-1, rows[0][0])

    f.save('untitled.xls')

def merge_files(user_path, sheet_index=0):
    if user_path == 'q':
        print("The program has been quited by command 'q'")
        return
    if user_path == 'd':
        print("Using default path")
        files = get_excel_files()   
    else:
        print("Using custom path: {}".format(user_path))
        files = get_excel_files(user_path)

    if files == []: return 0
    data = []
    for index in range(len(files)):
        file = files[index]
        data += read_excel(file, 2 if index != 0 else 0, sheet_index=sheet_index)
    #print(data)
    write_excel(data)
    return 1
