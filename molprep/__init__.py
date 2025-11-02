"""
MolPrep: Streamlined molecular preparation for virtual screening.

This package provides tools for preparing protein structures and drug-like
molecules for virtual screening workflows through an intuitive pipeline interface.
"""

# Version handling with setuptools-scm
try:
    from ._version import version as __version__
    from ._version import version_tuple
except ImportError:
    # Fallback for development or when _version.py doesn't exist
    __version__ = "0.0.0+unknown"
    version_tuple = (0, 0, 0, "unknown", "unknown")
__author__ = "Abhishek Tiwari"
__email__ = "abhishek@abhishek-tiwari.com"

__all__ = []
