# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

"""
Unit tests for bucket_wrapper.py functions.
"""

import io
from urllib.parse import urlparse
import uuid
import pytest

from botocore.exceptions import ClientError

import bucket_wrapper

def test_bucket_exists(stub_and_patch, make_unique_name, make_bucket):
    """Test that bucket existence is correctly determined."""
    stubber = stub_and_patch(bucket_wrapper, 'get_s3')

    bucket = make_bucket(stubber, bucket_wrapper.get_s3())

    stubber.stub_head_bucket(bucket.name)

    assert bucket_wrapper.bucket_exists(bucket.name)

def test_bucket_not_exists(stub_and_patch, make_unique_name, make_bucket):
    """Test that bucket nonexistence is correctly determined."""
    stubber = stub_and_patch(bucket_wrapper, 'get_s3')
    bucket_name = make_unique_name('bucket')

    stubber.stub_head_bucket(bucket_name, error_code='NoSuchBucket')

    assert not bucket_wrapper.bucket_exists(bucket_name)
    