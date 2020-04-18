import argparse
import os

from main import test


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--gpu", default="0")
    subparsers = parser.add_subparsers()

    subparser1 = subparsers.add_parser("test")
    subparser1.set_defaults(func=test)
    subparser1.add_argument("--arg1", required=True)
    subparser1.add_argument("--arg2", default="test_arg2")

    args = vars(parser.parse_args())

    gpu = args.pop("gpu")
    os.environ["CUDA_VISIBLE_DEVICES"] = gpu

    func = args.pop("func")
    func(**args)


if __name__ == "__main__":
    main()
