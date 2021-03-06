# AUTOGENERATED! DO NOT EDIT! File to edit: nbs/02_cli.ipynb (unless otherwise specified).

__all__ = ['send_to_pocketbook']

# Cell
import pathlib
import click

from .core import Target
from .mail import Emailer
from send_to_pb import utils as u

# Cell

@click.command()
@click.argument('location', nargs=1)
@click.option('--send-mail/--no-mail', default=True, help="send email or not?")
@click.option('--pocketbook/--myself', default=True, help="send to myself or pocketbook?")
def send_to_pocketbook(location,  send_mail, pocketbook):
    """Send file from location to pocketbook"""
    if pocketbook:
        receiver = "ddzlob@pbsync.com"
    else:
        receiver = "david.dobrinskiy@gmail.com"

    t = Target(location)

    if send_mail:
        for file in t.files:
            Emailer().send_file(to=receiver,
                                file=file,
                         )