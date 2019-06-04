# Frogger

A tool to generate text exports of your organizations Glassfrog roles, to allow easy archival/backup.

## Installation

Clone the repo, edit config/config.exs and supply your Glassfrog API key

Download and compile the dependencies:

```
mix deps.get
mix deps.compile
```

Then.. just run it:

```
mix get_roles
```

It will dump the roles, domains and accountabilities of the entire organization into a "pleasing" text-based format.

For example:

```
Role: Director of Pleasant Surprise in Team Growth & Development

Purpose: Making people happy.

Domains:


Accountabilities:
Identifying and acting on opportunities to surprise others with unexpected gestures of appreciation, condolence or gratitude.
Assisting other team members who would like to act on opportunities to surprise others with unexpected gestures of appreciation, condolence or gratitude.
Coming up with, or helping to come up with gift ideas for the above.
Keeping gift ideas personalized whenever possible.

Working within the budget guidelines established by the Expense Policy.
Asking team members requesting a Pleasant Surprise to use this form - https://forms.gle/XiAi4QXe5Pxiq3hNA
Completing team member requests originating from the Pleasant Surprise Request Form within 2 to 5 business days or setting expectations around completion time - hhttps://forms.gle/XiAi4QXe5Pxiq3hNA

Holders: xxx, yyy, zzz
```
