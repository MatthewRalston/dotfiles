#!/bin/bash
#   Copyright 2020 Matthew Ralston
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
# Author: Matt Ralston
# Date: 1/22/24
# Description: Create a new journal entry

TEMPLATE_DIR=/develop/repos/journal/journal_templates
JOURNAL_DIR=/ffast/Documents/orgs/journal

today=$(date -I)




if [ ! -f "$JOURNAL_DIR/daily_journal_${today}.md" ]; then
    # Remove current journal symlink
    rm $JOURNAL_DIR/current.md || true;
    # Copy the template at the current date
    cp $TEMPLATE_DIR/template_daily_journal2.md $JOURNAL_DIR/daily_journal_${today}.md
    # Recreate the symlink
    ln -s $JOURNAL_DIR/daily_journal_${today}.md $JOURNAL_DIR/current.md
else
    echo "Refusing to make new journal entry... existing journal file found: '$JOURNAL_DIR/daily_journal_${today}.md'" >&2
    exit 1
fi

