from __future__ import unicode_literals

from django.contrib.auth.models import User
from django.db import models


class BaseModel(models.Model):
    class Meta:
        abstract = True

    def before_insert(self):
        pass

    def after_insert(self):
        pass

    def before_update(self):
        pass

    def after_update(self):
        pass

    def before_save(self, is_new):
        if is_new:
            self.before_insert()
        else:
            self.before_update()

    def after_save(self, is_new):
        if is_new:
            self.after_insert()
        else:
            self.after_update()

    def save(self, **kwargs):
        is_new = self.pk is None

        self.before_save(is_new)

        super(BaseModel, self).save(**kwargs)

        self.after_save(is_new)


class TrackedModel(BaseModel):
    created = models.DateTimeField(auto_now_add=True)
    modified = models.DateTimeField(auto_now=True)

    class Meta:
        abstract = True


class Profile(TrackedModel):
    user = models.OneToOneField(User)

    def __unicode__(self):
        return self.user.__unicode__()
