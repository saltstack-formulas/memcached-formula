# Copyright 2013 Hewlett-Packard Development Company, L.P.
#
#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.
#
{% from "memcached/map.jinja" import defaults with context -%}

# Macro:
#
# get_config_item(item_name)
# item_name = parameter in the config to get
#
{%- macro get_config_item(item_name) -%}
{%- set default = defaults['config'].get(item_name, None) -%}
{%- set value = salt['pillar.get']('memcached:%s' % (item_name), default) -%}
{%- if value is string or value is number -%}
{{ value }}
{%- elif value is iterable -%}
{%- if not value -%}
None
{%- else -%}
{{ value | join(', ') }}
{%- endif -%}
{%- elif value is none -%}
None
{%- elif value -%}
True
{%- elif not value -%}
False
{%- endif -%}
{%- endmacro -%}