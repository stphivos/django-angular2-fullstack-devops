import json
from django.contrib.auth.models import User
from django.test import TestCase
from model_mommy import mommy
from model_mommy.generators import gen_string, gen_integer
from rest_framework import fields as drf_fields
from rest_framework.test import APIClient
from urllib import urlencode

from api import models


class BaseUnitTestCase(TestCase):
    def prepare_model(self, cls, identity=True, optional=True, **attrs):
        default = dict(
            _fill_optional=optional
        )
        if identity:
            default.update(id=gen_integer(min_int=1))
        return mommy.prepare(cls, **dict(default, **attrs))

    def format_date(self, value):
        return drf_fields.DateTimeField().to_representation(value)


class BaseIntegrationTestCase(BaseUnitTestCase):
    route = None

    def setUp(self):
        super(BaseIntegrationTestCase, self).setUp()

        self.client = APIClient()
        self.client.default_format = 'json'

        self.password = gen_string(8)
        self.user = self.create_user(password=self.password)
        self.user.profile = self.create_model(models.Profile)

    def tearDown(self):
        super(BaseIntegrationTestCase, self).tearDown()

    @property
    def base_endpoint(self):
        return '/api/{0}/'.format(self.route)

    def user_api(self, user=None):
        user = self.user if not user else user
        self.client.force_authenticate(user=user, token=user.token if hasattr(user, 'token') else None)

        return self.client

    def pub_api(self):
        self.client.defaults.update({'HTTP_USER_AGENT': 'Tests'})
        self.client.force_authenticate(user=None)

        return self.client

    def get_endpoint(self, base_path, *relative_paths, **query):
        target_path = base_path + '/'.join([str(x) for x in relative_paths]) + ('/' if relative_paths else '')
        if 'format' not in query:
            query.update({'format': 'json'})
        return target_path + '?' + urlencode(query)

    def assert_response(self, response, code):
        query = ('?' + response.request['QUERY_STRING']) if response.request['QUERY_STRING'] else ''
        self.assertEqual(
            response.status_code,
            code,
            '{0} {1} produced {2} instead of {3} => {4}'.format(
                response.request['REQUEST_METHOD'],
                response.request['PATH_INFO'] + query,
                response.status_code,
                code,
                response.content
            )
        )

    def get_json(self, response):
        return json.loads(response.content)

    def create_model(self, cls, optional=True, **attrs):
        return mommy.make(cls, _fill_optional=optional, **attrs)

    def create_user(self, **kwargs):
        defaults = dict(
            is_active=kwargs.get('is_active', True),
            username=kwargs.get('username', gen_string(10)),
            email=kwargs.get('email', gen_string(10) + '@localhost')
        )

        user = self.prepare_model(User, identity=False, **dict(defaults, **kwargs))
        user.set_password(kwargs.get('password', gen_string(8)))
        user.save()

        return user

    def create_profile(self, **kwargs):
        defaults = dict(
            user=kwargs.get('user', self.create_user()),
        )
        return self.create_model(models.Profile, **dict(defaults, **kwargs))
