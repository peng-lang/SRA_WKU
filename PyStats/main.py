from merge import get_excel_files
from merge import merge_files

user_path = input("Type path or command here: ")
if user_path == 's':
    user_path = input("Enter path here: ")
    sheet_index = input("Enter sheet index(for all files) here: ")
    merge_files(user_path, sheet_index)
else:
    merge_files(user_path)
