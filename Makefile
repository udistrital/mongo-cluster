all: .git/hooks/pre-commit
	.git/hooks/pre-commit

.git/hooks/pre-commit: backup scripts/pre-commit.sh
	cp -f scripts/pre-commit.sh .git/hooks/pre-commit
	chmod +x .git/hooks/pre-commit
	touch .git/hooks/pre-commit

backup: .git/hooks
	diff .git/hooks/pre-commit.backup .git/hooks/pre-commit >/dev/null 2>/dev/null || { \
		echo backing up your .git/hooks/pre-commit file ; \
		cp -f .git/hooks/pre-commit .git/hooks/pre-commit.backup.$$(date +%s) >/dev/null 2>/dev/null ; \
	  cp -f .git/hooks/pre-commit .git/hooks/pre-commit.backup >/dev/null 2>/dev/null ; \
		true ; \
	}

.git/hooks:
	mkdir -p .git/hooks

.PHONY: all backup
.SILENT: backup .git/hooks/pre-commit
