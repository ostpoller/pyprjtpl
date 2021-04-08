from .context import package_name


def test_app(capsys, example_fixture):
    # pylint: disable=W0612,W0613
    package_name.HelloWorld.run()
    captured = capsys.readouterr()

    assert "Hello World..." in captured.out
