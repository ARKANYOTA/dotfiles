" ALL: {{{1
function! g:CGenerateData() " {{{2
python3 << EOF
import vim
import os
from os import listdir
import subprocess
import re
def list_dir(path, is_file):
	return [name for name in os.listdir(path) 
		if (os.path.isfile(os.path.join(path, name))
			if is_file else
			os.path.isdir(os.path.join(path, name)))
	]
def get_files_infos(path):
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
for course_file in list_dir(cours_path, 1):
	val[course_file] = get_files_infos(cours_path+"/"+course_file)
vim.command("let g:Cdata="+str(val))

import json
with open(f"{cours_path}/../data.json", "w") as f:
	json.dump(val, f)
# for i,j in val.items(): # TODO: dedug
# 	print(i,j)  # TODO: debug
EOF
endfunction

function! g:CLoadData() " {{{2
python3 << EOF
import vim
cours_path = vim.eval("g:cours_path") # Path with notes /home/arkanyota/Cours2022Git/notes
import json
try:
	val = json.load(open("{cours_path}/../data.json", "r"))
except:
	vim.command("call g:CGenerateData()")
vim.command("let g:Cdata="+str(val))

EOF
endfunction

function! g:CGenerateHTML() " {{{2
python3 << EOF
import vim
import os
from os import listdir
import subprocess
import re
try:
	data = vim.eval("g:Cdata")
except:
	print("Générer d'abort la data (:call CGenerateData)")
	data = None

if data is not None:
	for cours in data.keys():
		if "toc" in data[cours].keys():
			print(cours+"  :  "+data[cours]["path"])
			makedir(os.path.dirname(data[cours]["path"].replace("Cours2022Git/notes", "Cours2022Git/html")))
			with open(data[cours]["path"].replace("Cours2022Git/notes", "Cours2022Git/html"), "w") as f:
				f.write(write_markdown(data[cours]["path"]))
		else:
			print("Folder : "+cours)
EOF
endfunction


function s:python_init() " {{{2
python3 << EOF
import vim
def write_var(var, val):
	vim.command("let g:"+var+"="+val)

def write_markdown(filename):
	result = subprocess.run(("multimarkdown "+filename).split(" "), stdout=subprocess.PIPE)
	return result.stdout.decode('utf-8', 'replace') # model(result.stdout.decode('utf-8', 'replace'), math, dark)

import os
def makedir(path):
	if os.path.exists(path):
		return True
	if os.path.exists(os.path.dirname(path)):
		print("\t ex")
		os.mkdir(path)
		return True
	else:
		print("\t rec")
		makedir(os.path.dirname(path))
		os.mkdir(path)
EOF
endfunction
exec s:python_init()

