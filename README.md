# Koricode Skills

A curated collection of **agent skills** designed for Claude Code and compatible AI coding assistants. Each skill provides domain-specific knowledge, best practices, and guided workflows that enhance
an agent's ability to perform specialized tasks.

## What are Skills?

Skills are modular packages that extend Claude Code's capabilities. They provide:

- Specialized domain knowledge and best practices
- Guided workflows and procedures
- Code templates and automation scripts
- Verification checklists and quality standards

## Available Skills

> Skills will be added as the collection grows. Check back soon!

## Installation

### Quick install (recommended)

Install this repository into your agent skills directory with the skills CLI:

```shell
npx skills add https://github.com/koricode/skills
```

### Manual Installation

Copy or symlink the skills you need into your Claude Code (or Codex, Cursor, etc.) configuration:

```shell
# Copy a single skill
cp -r skills/react ~/.claude/skills/react

# Or symlink the entire collection
ln -s $(pwd)/skills ~/.claude/skills
```

## Skills Structure

Each skill follows a consistent structure:

```
skill-name/
├── SKILL.md          # Skill metadata and documentation
├── README.md         # Detailed skill guide
├── examples/         # Reference implementations
└── templates/        # Code templates (if applicable)
```

### SKILL.md Format

Each skill includes:

- **Name**: Skill identifier
- **Description**: What the skill does
- **Usage**: How to invoke and use the skill
- **Examples**: Real-world use cases
- **Verification**: Quality checklist

## Contributing

Contributions are welcome! To add a new skill:

1. Create a new directory with your skill name
2. Add a `SKILL.md` file with metadata
3. Include documentation and examples
4. Submit a pull request

## License

[Add your license information here]

## About

Created and maintained by [Koricode](https://github.com/koricode)