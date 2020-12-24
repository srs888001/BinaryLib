import re, os, time, configparser

spec_path = './ABC.podspec'
spec_name = 'ABC.podspec'
specs_name = 'ABC'
source_specs_url = 'git@github.com:srs888001/BinaryLib.git'

config_ini_path = './upload.ini'

def run():
    pod_install()

    tag = find_podspec_tag(spec_path)
    message = find_whatsnew_from_ini(config_ini_path,tag)
    git_commit(tag, message)

    res = lint_push_podspec(spec_name,specs_name,source_specs_url)
    if res == 0:
        update_local_specs(specs_name)
    else :
        delete_tag(tag)

# Update local specs
def update_local_specs(specs_name):
    os.system('pod repo update %s' % specs_name)

def pod_install():
    print('cd Example/')
    os.chdir('Example')

    print('pod install')
    os.system('pod install')

    print('cd ../')
    os.chdir('../')

# PosSpec Lint and push
def lint_push_podspec(spec_name, specs_name, source_specs_url):
    print('code git push complete, ready to lint and push spec !')
    time.sleep(3)

    spec_lint = 'pod lib lint --sources=%s --allow-warnings --verbose --use-libraries' % source_specs_url
    print(spec_lint)
    res = os.system(spec_lint)

    if res == 0:
        spec_push = 'pod repo push %s %s --allow-warnings --verbose --use-libraries' % (specs_name, spec_name)
        print(spec_push)
        res = os.system(spec_push)
    return res

# Tags
def git_commit(tag, commit_msg):
    git_add = 'git add .'
    print(git_add)
    os.system(git_add)

    git_status = 'git status'
    print(git_status)
    os.system(git_status)

    git_commit = "git commit -m '%s'" % commit_msg
    print(git_commit)
    os.system(git_commit)

    git_checkout = "git checkout master"
    print(git_checkout)
    os.system(git_checkout)
    git_pull = "git pull"
    print(git_pull)
    os.system(git_pull)
    
    git_push = 'git push origin'
    print(git_push)
    os.system(git_push)
    
    git_tag = 'git tag %s'%tag
    print(git_tag)
    res = os.system(git_tag)
    os.system('git push origin --tags')
    return res
    
# deleteTag
def delete_tag(tag):
    git_tag = 'git tag -d %s'%tag
    print(git_tag)
    os.system(git_tag)

    git_push = 'git push origin :refs/tags/%s'%tag
    print(git_push)
    os.system(git_push)

# File
def find_whatsnew_from_ini(file_path,tag):
    if '.Binary' in tag:
        tag = tag.replace('.Binary','')
    cf = configparser.ConfigParser()
    cf.read(file_path,encoding='utf-8')

    whats_new = cf.get("v%s"%tag,"whats_new")
    if len(whats_new) == 0:
        whats_new = 'ready to push %s'%tag
    print('find whatsnew:',whats_new)
    return whats_new


def find_podspec_tag(file_path):
    with open(file_path, 'r') as f:
        contents = f.read().replace('\n', '').replace('\r', '').replace(' ', '')
        version = findContentInMiddle(contents, "s.version='", "'s")
        print('find podspec version %s from %s' % (version, file_path))
        return version


def findContentInMiddle(contents, a, b):
    str = "(?s)(?<=%s).*?(?=%s)" % (a, b)

    res = re.search(str, contents).group()
    return res


if __name__ == '__main__':
    run()
