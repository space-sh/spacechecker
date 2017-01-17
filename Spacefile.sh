#
# Copyright 2016 Blockie AB
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#
# spacechecker - Space module analyzer
#

# Disable warning about indirectly checking status code
# shellcheck disable=SC2181

#=====================
# SPACECHECKER_DEP_INSTALL
#
# Check dependencies for this module.
#
#=====================
SPACECHECKER_DEP_INSTALL ()
{
    SPACE_DEP="PRINT"    # shellcheck disable=SC2034
    PRINT "Checking for dependencies." "info"

    if [ "$?" -eq 0 ]; then
        PRINT "Dependencies found." "ok"
    else
        PRINT "Failed finding dependencies." "error"
        return 1
    fi
}


# Disable warning about indirectly checking status code
# shellcheck disable=SC2181

#=====================
# _CHECK_DEP_INSTALL_NODE
#
# Check if module has dep_install node implemented.
#
#=====================
_CHECK_DEP_INSTALL_NODE()
{
    space -f "$_dir_name/Spacefile.yaml" /_dep_install/ -h > /dev/null 2>&1
    if [ "$?" -ne 0 ]; then
        PRINT "expected _dep_install node in Spacefile.yaml" "warning"
    else
        PRINT "OK" "ok"
    fi
}

#=====================
# _CHECK_LICENSE_FILE_EXISTS
#
# Check if module has LICENSE file present.
#
#=====================
_CHECK_LICENSE_FILE_EXISTS()
{
    if [ -f "$_dir_name/LICENSE" ]; then
        PRINT "OK" "ok"
    else
        PRINT "expected LICENSE file" "warning"
    fi
}

#=====================
# _CHECK_CHANGELOG_FILE_EXISTS
#
# Check if module has CHANGELOG file present.
#
#=====================
_CHECK_CHANGELOG_FILE_EXISTS()
{
    if [ -f "$_dir_name/CHANGELOG.md" ]; then
        PRINT "OK" "ok"
    else
        PRINT "expected CHANGELOG.md file" "warning"
    fi
}

#=====================
# _CHECK_README_FILE_EXISTS
#
# Check if module has README file present.
#
#=====================
_CHECK_README_FILE_EXISTS()
{
    if [ -f "$_dir_name/README.md" ]; then
        PRINT "OK" "ok"
    else
        PRINT "expected README.md file" "warning"
    fi
}

#=====================
# _CHECK_STABLE_FILE_EXISTS
#
# Check if module has stable file present.
#
#=====================
_CHECK_STABLE_FILE_EXISTS()
{
    if [ -f "$_dir_name/stable.txt" ]; then
        PRINT "OK" "ok"
    else
        PRINT "expected stable.txt file" "warning"
    fi
}

#=====================
# _CHECK_TESTS_EXIST
#
# Check if module has tests structure in place.
#
#=====================
_CHECK_TESTS_EXIST()
{
    if [ -d "$_dir_name/test" ]; then
        if [ -f "$_dir_name/test/test.yaml" ] \
            && [ -f "$_dir_name/test/test.sh" ]; then
            PRINT "OK" "ok"
        else
            PRINT "expected test.yaml,sh in the test directory " "warning"
        fi
    else
        PRINT "expected test directory" "warning"
    fi
}

#=====================
# _CHECK_GITLABCI_FILE_EXISTS
#
# Check if module has gitlab-ci file present.
#
#=====================
_CHECK_GITLABCI_FILE_EXISTS()
{
    if [ -f "$_dir_name/.gitlab-ci.yml" ]; then
        PRINT "OK" "ok"
    else
        PRINT "expected .gitlab-ci.yml file" "warning"
    fi
}


# Disable warning about indirectly checking status code
# shellcheck disable=SC2181

#=====================
# _CHECK_BASHISMS
#
# Check if module possibly has bashisms
#
#=====================
_CHECK_BASHISMS()
{
    local _script_file=
    if [ -f "Spacefile.sh" ]; then
        _script_file="Spacefile.sh"
    elif [ -f "Spacefile.bash" ]; then
        _script_file="Spacefile.bash"
    fi

    if command -v "checkbashisms" >/dev/null; then
        checkbashisms -f "$_script_file" >/dev/null 2>&1
        if [ "$?" -ne 0 ]; then
            PRINT "Possible bashisms found in $_script_file with checkbashisms" "warning"
        fi
    fi

    if command -v "shellcheck" >/dev/null; then
        shellcheck  --exclude=2148 "$_script_file" >/dev/null 2>&1
        if [ "$?" -ne 0 ]; then
            PRINT "Possible bashisms found in $_script_file with shellcheck" "warning"
        fi
    fi
}

#=====================
# _CHECK_MODULE
#
# Check if module complies with Space module guidelines.
#
# Parameters:
#   $1: module directory path
#
# Returns:
#   0: success
#   1: failed. Directory path is not pointing to a module.
#
#=====================
_CHECK_MODULE()
{
    # shellcheck disable=SC2034
    SPACE_DEP="PRINT _CHECK_DEP_INSTALL_NODE _CHECK_LICENSE_FILE_EXISTS _CHECK_CHANGELOG_FILE_EXISTS _CHECK_README_FILE_EXISTS _CHECK_STABLE_FILE_EXISTS _CHECK_TESTS_EXIST _CHECK_GITLABCI_FILE_EXISTS _CHECK_BASHISMS"

    if [ "$#" -eq 0 ]; then
        PRINT "missing module directory path to analyze" "error"
        return 1
    fi

    local _dir_name="$1"
    # Append PWD if path is relative
    if [ ! "${_dir_name}" = "${_dir_name#/}" ]; then
        _dir_name="${PWD}/${_dir_name}"
    fi

    # Check for Spacefile.sh|.bash,yaml
    if [ -f "$_dir_name/Spacefile.yaml" ]; then
        if [ -f "$_dir_name/Spacefile.sh" ] \
           || [ -f "$_dir_name/Spacefile.bash" ]; then
            PRINT "OK" "ok"
            _CHECK_DEP_INSTALL_NODE
            _CHECK_LICENSE_FILE_EXISTS
            _CHECK_CHANGELOG_FILE_EXISTS
            _CHECK_README_FILE_EXISTS
            _CHECK_STABLE_FILE_EXISTS
            _CHECK_TESTS_EXIST
            _CHECK_GITLABCI_FILE_EXISTS
            _CHECK_BASHISMS
        else
            PRINT "expected Spacefile.sh|bash in directory: $_dir_name" "error"
            exit 1
        fi
    else
        PRINT "expected Spacefile.yaml in directory: $_dir_name" "error"
        exit 1
    fi
}

