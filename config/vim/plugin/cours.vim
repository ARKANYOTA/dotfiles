" PYTHON_INIT: {{{1
function s:python_init() "{{{2
python3 << EOF
# }}}
import vim
def write_var(var, val):
	vim.command("let g:"+var+"="+val)
# {{{2
EOF
endfunction
" }}}
" }}}
" VIM_INIT: {{{1
let g:cours_path = "/home/ay/Cours2022Git/notes"
" }}}
" Load Data: {{{1
function! s:CGenerateData() " {{{2
python3 << EOF
# }}}
# Imports: {{{3
import vim
import os
from os import listdir
import subprocess
import re
def list_dir(path, is_file): # {{{3
	return [name for name in os.listdir(path) 
		if (os.path.isfile(os.path.join(path, name))
			if is_file else
			os.path.isdir(os.path.join(path, name)))
	]
# }}}
def get_files_infos(path): # {{{3
	try:
		wc = subprocess.check_output("wc -cmwlL \""+path+"\"", shell=True)
		wc = wc.decode("utf-8").split()[0:5]
	except:
		print("path not found, file delete or rename, make a reload(r)")
	name = path.split("/")[-1]
	try:
		toc_data = []
		for i in open(path, "r").readlines():
			tmp_match = re.match("(#{1,6})\\s(.+)", i)
	# 		toc_data.append(str(tmp_match.group(2)) if tmp_match is not None else "")
			if tmp_match is not None:
				toc_data.append([str(tmp_match.group(2).strip()), len(tmp_match.group(1))])
	except:
		toc_data = ["Unknown file type", 0]
	return {
		"toc": toc_data,# open(path, "r").readlines(),
		"path": path,
		"name": name,
		"ligne": wc[0],
		"words": wc[1],
		"chars": wc[2],
		"bytes": wc[3],
		"max_ligne": wc[4],
		"type" : "file",
		"attributes": 0x0,
		"extention": name.split(".")[-1]
	}
# }}}
# Courses {{{4
cours_path = vim.eval("g:cours_path") # Path with notes /home/arkanyota/Cours2022Git/notes
val = {}
for course in list_dir(cours_path, 0):
	course_path = cours_path+"/"+course
	val[course] = {
		"type" : "course",
		"name":course,
		"path": course_path,
		"folder" : {}
	}
	# Inter {{{5
	for inter in list_dir(course_path, 0):
		inter_path = course_path + "/" + inter
		val[course]["folder"][inter] = {
			"fold" : 1,
			"name":inter,
			"path" : inter_path,
			"type" : "inter",
			"files" : {}
		}
		for file in list_dir(inter_path, 1): # TODO: File in inter feature
			f_path = inter_path + "/" + file
			val[course]["folder"][inter]["files"][file] = get_files_infos(f_path)
	# for inter_file in list_dir(cours_path, 1): # TODO: File in inter feature
	# 	val[inter_file] = get_files_infos(cours_path+"/"+course_file)
	# }}}
for course_file in list_dir(cours_path, 1):
	val[course_file] = get_files_infos(cours_path+"/"+course_file)
# }}}
vim.command("let g:Cdata="+str(val))

# DEBUG: TODO; REMOVE
# import json
# with open("coursdebug.json", "w") as f:
# 	json.dump(val, f)
# for i,j in val.items(): # TODO: dedug
# 	print(i,j)  # TODO: debug
# {{{2
EOF
endfunction
" }}}
" }}}


function! s:CCTest()
"	exec s:CGenerateData()
	echo "e" 
endfunction

exec s:python_init()
command! CCTest call s:CCTest()
command! CGenerateData call s:CGenerateData()

