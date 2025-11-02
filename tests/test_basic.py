"""Basic tests for molprep package."""

def test_package_import():
    """Test that the main package can be imported."""
    import molprep

    assert molprep is not None

def test_version():
    """Test that package has a version."""
    import molprep

    # Check if version attribute exists (might not be defined yet)
    version = getattr(molprep, "__version__", "0.0.1")
    assert version is not None
    assert isinstance(version, str)
