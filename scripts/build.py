 #!/usr/bin/env python
  
import shutil, os, subprocess, re



"""
TODO:
Social Publish when a path has new files added to it.
"""
TEMPLATE = "./templates/blog.html"
SRC_DIR = "./src/"
DEST_DIR = "./dist/"

shutil.rmtree(DEST_DIR)
os.makedirs(DEST_DIR)



def build(src_dir, dest_dir): 
    for (rootDir,dirs,files) in os.walk(src_dir, topdown=True):
        # create the destination path
        dest = rootDir.replace(src_dir, dest_dir)
        os.makedirs(dest, exist_ok=True)

        for file in files:
            if(file[0] == "."):
                # if file is a dot file noop
                continue
            #split the name to root, extension
            root, ext = os.path.splitext(file)
            if(ext == ".md"):
                pandoc = [
                    "pandoc",
                    "-f", "markdown", # from markdown not markdown_strict apparently b/c we like our yalma metadata.
                    "-t", "html", # to hypertext markup language
                    os.path.join(rootDir, file), # innie
                    "-o", os.path.join(dest, root+".html"), # outtie
                    "--template="+TEMPLATE, # using template
                    "--wrap=none", # don't wrap
                 
                ]
                print("Building "+ pandoc[5])
                std_out = str(subprocess.check_output(pandoc, shell=True), encoding="utf-8")
                print(std_out)
            else:
                shutil.copy2(os.path.join(rootDir, file), os.path.join(dest, file))
    shutil.rmtree(os.path.join(DEST_DIR,".obsidian/"))
# -----------------
build(SRC_DIR, DEST_DIR)
