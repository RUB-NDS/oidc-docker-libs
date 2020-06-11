--
-- PostgreSQL database dump
--

-- Dumped from database version 11.7 (Debian 11.7-2.pgdg90+1)
-- Dumped by pg_dump version 11.7 (Debian 11.7-2.pgdg90+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO keycloak;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO keycloak;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO keycloak;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO keycloak;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO keycloak;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO keycloak;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO keycloak;

--
-- Name: client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO keycloak;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    value character varying(4000),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_attributes OWNER TO keycloak;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO keycloak;

--
-- Name: client_default_roles; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_default_roles (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_default_roles OWNER TO keycloak;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO keycloak;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO keycloak;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO keycloak;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO keycloak;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_client (
    client_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO keycloak;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO keycloak;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO keycloak;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO keycloak;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO keycloak;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO keycloak;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO keycloak;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO keycloak;

--
-- Name: component; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO keycloak;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE public.component_config OWNER TO keycloak;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO keycloak;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO keycloak;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO keycloak;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO keycloak;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO keycloak;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255)
);


ALTER TABLE public.event_entity OWNER TO keycloak;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE public.fed_user_attribute OWNER TO keycloak;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO keycloak;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO keycloak;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO keycloak;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO keycloak;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO keycloak;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO keycloak;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO keycloak;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO keycloak;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO keycloak;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO keycloak;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO keycloak;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO keycloak;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO keycloak;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO keycloak;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO keycloak;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO keycloak;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO keycloak;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO keycloak;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO keycloak;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO keycloak;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO keycloak;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO keycloak;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.realm OWNER TO keycloak;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_attribute OWNER TO keycloak;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO keycloak;

--
-- Name: realm_default_roles; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_default_roles (
    realm_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_roles OWNER TO keycloak;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO keycloak;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO keycloak;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO keycloak;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO keycloak;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO keycloak;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO keycloak;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO keycloak;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO keycloak;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO keycloak;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO keycloak;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO keycloak;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode character varying(15) NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO keycloak;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO keycloak;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy character varying(20),
    logic character varying(20),
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO keycloak;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO keycloak;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO keycloak;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO keycloak;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO keycloak;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO keycloak;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO keycloak;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE public.user_attribute OWNER TO keycloak;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO keycloak;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO keycloak;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO keycloak;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO keycloak;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO keycloak;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO keycloak;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO keycloak;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO keycloak;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO keycloak;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO keycloak;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO keycloak;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO keycloak;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO keycloak;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO keycloak;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
b6d224bb-dbbe-4ccb-bf61-672261f0509e	\N	auth-cookie	master	342e5625-3dde-4139-88c8-486056e92bc9	2	10	f	\N	\N
75485622-db10-4d56-941f-047bb2fd3fb3	\N	auth-spnego	master	342e5625-3dde-4139-88c8-486056e92bc9	3	20	f	\N	\N
6e2f1c39-2fee-4695-9fac-70c3c56b5e5c	\N	identity-provider-redirector	master	342e5625-3dde-4139-88c8-486056e92bc9	2	25	f	\N	\N
3b377620-7165-445b-b8bd-5176b301949b	\N	\N	master	342e5625-3dde-4139-88c8-486056e92bc9	2	30	t	c46049a2-b9ce-4e06-b988-b9c6153d4ebd	\N
889029c8-d46c-4b6f-99a4-34b245dbeb51	\N	auth-username-password-form	master	c46049a2-b9ce-4e06-b988-b9c6153d4ebd	0	10	f	\N	\N
7448c14c-da52-4582-99b7-c3fd3db0fcf4	\N	\N	master	c46049a2-b9ce-4e06-b988-b9c6153d4ebd	1	20	t	10771eb3-b002-4210-b80a-626c071a6f1f	\N
110490c4-0cb0-42b4-a005-d26d2591ac1c	\N	conditional-user-configured	master	10771eb3-b002-4210-b80a-626c071a6f1f	0	10	f	\N	\N
7bcd27cd-8e31-4a77-aff1-f4a7ec2a7b87	\N	auth-otp-form	master	10771eb3-b002-4210-b80a-626c071a6f1f	0	20	f	\N	\N
34c7b419-466f-4c84-9f69-cdb3dcb9ccd2	\N	direct-grant-validate-username	master	6c59dea3-ad37-49e1-9c5c-5d091222e50f	0	10	f	\N	\N
db2b970f-5485-45ac-90d4-721748e1cc46	\N	direct-grant-validate-password	master	6c59dea3-ad37-49e1-9c5c-5d091222e50f	0	20	f	\N	\N
d1cb8962-1093-4b0e-a851-974104917827	\N	\N	master	6c59dea3-ad37-49e1-9c5c-5d091222e50f	1	30	t	5cfb9f32-0e0d-49ea-a259-a761fe6bbe0d	\N
b0789757-24bf-4a67-a4c7-039a9e10b7ad	\N	conditional-user-configured	master	5cfb9f32-0e0d-49ea-a259-a761fe6bbe0d	0	10	f	\N	\N
323baa53-b45e-4cca-8599-2ce8d6639412	\N	direct-grant-validate-otp	master	5cfb9f32-0e0d-49ea-a259-a761fe6bbe0d	0	20	f	\N	\N
14bdb5dc-f5ec-4626-8e9e-48d75178fe2a	\N	registration-page-form	master	206563a1-19e0-4ec8-8452-4ca549aa5b40	0	10	t	24546ae2-57f1-4fd9-a928-8629dc7a1838	\N
f3a62555-742a-4f3c-8888-93ac257508c1	\N	registration-user-creation	master	24546ae2-57f1-4fd9-a928-8629dc7a1838	0	20	f	\N	\N
63cacd0e-927f-4eb4-bfbb-1bdc085b447f	\N	registration-profile-action	master	24546ae2-57f1-4fd9-a928-8629dc7a1838	0	40	f	\N	\N
57fe57b9-db0e-425a-9837-fcbd1b2f265f	\N	registration-password-action	master	24546ae2-57f1-4fd9-a928-8629dc7a1838	0	50	f	\N	\N
d967527a-192b-48cf-83a7-207b0dff6092	\N	registration-recaptcha-action	master	24546ae2-57f1-4fd9-a928-8629dc7a1838	3	60	f	\N	\N
78fa4ac4-05a0-4208-b973-f5b9f3576d45	\N	reset-credentials-choose-user	master	733b84bd-aac5-42a8-b736-5e3e304b77e3	0	10	f	\N	\N
b6843f36-6295-459e-a251-4f0dbadb0eed	\N	reset-credential-email	master	733b84bd-aac5-42a8-b736-5e3e304b77e3	0	20	f	\N	\N
2e64e22e-09c9-44b9-9a34-d9f65ff05bcb	\N	reset-password	master	733b84bd-aac5-42a8-b736-5e3e304b77e3	0	30	f	\N	\N
5c6cac55-d529-40ac-b44d-7fe1d549a50b	\N	\N	master	733b84bd-aac5-42a8-b736-5e3e304b77e3	1	40	t	57a80373-83bb-4e61-94a2-ae2c5306b728	\N
3a8cd81e-6846-48e2-a714-206723a95971	\N	conditional-user-configured	master	57a80373-83bb-4e61-94a2-ae2c5306b728	0	10	f	\N	\N
96b6c5b7-95f3-429e-8b4b-308ce3910f7b	\N	reset-otp	master	57a80373-83bb-4e61-94a2-ae2c5306b728	0	20	f	\N	\N
5d399f93-5fb5-4854-ad85-55c44c906956	\N	client-secret	master	2e6b4e96-c95e-404a-b730-7e33da619eb9	2	10	f	\N	\N
df93eb18-dca7-43d4-af55-cee189682be0	\N	client-jwt	master	2e6b4e96-c95e-404a-b730-7e33da619eb9	2	20	f	\N	\N
30c1dab8-68f9-4ff3-b820-aab03003602b	\N	client-secret-jwt	master	2e6b4e96-c95e-404a-b730-7e33da619eb9	2	30	f	\N	\N
2386b3f2-d8e0-468d-b5d2-73d208b697a3	\N	client-x509	master	2e6b4e96-c95e-404a-b730-7e33da619eb9	2	40	f	\N	\N
993b2a1f-2283-478d-b0fd-9ba0f38613e2	\N	idp-review-profile	master	c507012b-0683-4a65-bb11-74c123ceb5d2	0	10	f	\N	ae796b87-d9f6-4d28-af93-fa3ffc6f4b93
2c38b537-5318-4e06-8607-915a91bd6164	\N	\N	master	c507012b-0683-4a65-bb11-74c123ceb5d2	0	20	t	03e205aa-c36e-43e1-ba70-8e35a144af1a	\N
26a86ef4-1564-4025-a255-4621d4daa353	\N	idp-create-user-if-unique	master	03e205aa-c36e-43e1-ba70-8e35a144af1a	2	10	f	\N	b5035f35-8243-4f85-8871-72f6c272cd61
f742dd3b-d1c5-4799-b6c2-9040e71244dd	\N	\N	master	03e205aa-c36e-43e1-ba70-8e35a144af1a	2	20	t	e3c45de5-9c20-4fee-a4c3-847c51e92c85	\N
b3b893c1-d5ee-4833-bf45-063ecbeafd66	\N	idp-confirm-link	master	e3c45de5-9c20-4fee-a4c3-847c51e92c85	0	10	f	\N	\N
084fefcc-586b-4d90-857d-a2f4808cd98a	\N	\N	master	e3c45de5-9c20-4fee-a4c3-847c51e92c85	0	20	t	9821c6d3-e0be-4056-9c95-b1821f22a6c8	\N
4f40f4fb-a4bc-4705-b99b-12814cba2352	\N	idp-email-verification	master	9821c6d3-e0be-4056-9c95-b1821f22a6c8	2	10	f	\N	\N
1ceff45d-e945-4c83-9d57-8003e519370a	\N	\N	master	9821c6d3-e0be-4056-9c95-b1821f22a6c8	2	20	t	9d567e1d-8bad-48dd-ad98-06f03a91842f	\N
ee7e0404-1ffe-4a09-a2e2-b45bed8a0571	\N	idp-username-password-form	master	9d567e1d-8bad-48dd-ad98-06f03a91842f	0	10	f	\N	\N
42a4dde1-1931-442c-8f71-212992bd0a21	\N	\N	master	9d567e1d-8bad-48dd-ad98-06f03a91842f	1	20	t	68600f70-4e24-4125-9f1d-8be638669627	\N
edaf123b-b463-473b-a6d0-338bfa4ccf29	\N	conditional-user-configured	master	68600f70-4e24-4125-9f1d-8be638669627	0	10	f	\N	\N
18a08ea5-fa38-4598-8673-feb900b51ebe	\N	auth-otp-form	master	68600f70-4e24-4125-9f1d-8be638669627	0	20	f	\N	\N
579498ad-df3c-4764-8cc9-56d82318b90e	\N	http-basic-authenticator	master	86c9523c-0c37-45bf-955f-f517a0aa0c1d	0	10	f	\N	\N
d2615abb-758b-4e33-a2f6-8cb5d48424e4	\N	docker-http-basic-authenticator	master	56a75683-944d-4dcd-baac-761d990a132c	0	10	f	\N	\N
c90fe25b-774d-41dc-917f-3592845d2cf8	\N	no-cookie-redirect	master	5b59e311-3a23-470c-aec6-126e9ebe4dca	0	10	f	\N	\N
0b2c6899-9c2b-4e09-a4d6-fa7aa9064e9d	\N	\N	master	5b59e311-3a23-470c-aec6-126e9ebe4dca	0	20	t	025c7efb-df11-4aac-90a6-ed9dc8a26dd5	\N
be8dc8a6-30ed-4240-8002-b5d863763c88	\N	basic-auth	master	025c7efb-df11-4aac-90a6-ed9dc8a26dd5	0	10	f	\N	\N
a002a241-bed0-45ce-8227-2175d6b98904	\N	basic-auth-otp	master	025c7efb-df11-4aac-90a6-ed9dc8a26dd5	3	20	f	\N	\N
bbf14fd5-8343-4558-bf5a-cb82c00929dd	\N	auth-spnego	master	025c7efb-df11-4aac-90a6-ed9dc8a26dd5	3	30	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
342e5625-3dde-4139-88c8-486056e92bc9	browser	browser based authentication	master	basic-flow	t	t
c46049a2-b9ce-4e06-b988-b9c6153d4ebd	forms	Username, password, otp and other auth forms.	master	basic-flow	f	t
10771eb3-b002-4210-b80a-626c071a6f1f	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
6c59dea3-ad37-49e1-9c5c-5d091222e50f	direct grant	OpenID Connect Resource Owner Grant	master	basic-flow	t	t
5cfb9f32-0e0d-49ea-a259-a761fe6bbe0d	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
206563a1-19e0-4ec8-8452-4ca549aa5b40	registration	registration flow	master	basic-flow	t	t
24546ae2-57f1-4fd9-a928-8629dc7a1838	registration form	registration form	master	form-flow	f	t
733b84bd-aac5-42a8-b736-5e3e304b77e3	reset credentials	Reset credentials for a user if they forgot their password or something	master	basic-flow	t	t
57a80373-83bb-4e61-94a2-ae2c5306b728	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	master	basic-flow	f	t
2e6b4e96-c95e-404a-b730-7e33da619eb9	clients	Base authentication for clients	master	client-flow	t	t
c507012b-0683-4a65-bb11-74c123ceb5d2	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	master	basic-flow	t	t
03e205aa-c36e-43e1-ba70-8e35a144af1a	User creation or linking	Flow for the existing/non-existing user alternatives	master	basic-flow	f	t
e3c45de5-9c20-4fee-a4c3-847c51e92c85	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	master	basic-flow	f	t
9821c6d3-e0be-4056-9c95-b1821f22a6c8	Account verification options	Method with which to verity the existing account	master	basic-flow	f	t
9d567e1d-8bad-48dd-ad98-06f03a91842f	Verify Existing Account by Re-authentication	Reauthentication of existing account	master	basic-flow	f	t
68600f70-4e24-4125-9f1d-8be638669627	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
86c9523c-0c37-45bf-955f-f517a0aa0c1d	saml ecp	SAML ECP Profile Authentication Flow	master	basic-flow	t	t
56a75683-944d-4dcd-baac-761d990a132c	docker auth	Used by Docker clients to authenticate against the IDP	master	basic-flow	t	t
5b59e311-3a23-470c-aec6-126e9ebe4dca	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	master	basic-flow	t	t
025c7efb-df11-4aac-90a6-ed9dc8a26dd5	Authentication Options	Authentication options.	master	basic-flow	f	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
ae796b87-d9f6-4d28-af93-fa3ffc6f4b93	review profile config	master
b5035f35-8243-4f85-8871-72f6c272cd61	create unique user config	master
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
ae796b87-d9f6-4d28-af93-fa3ffc6f4b93	missing	update.profile.on.first.login
b5035f35-8243-4f85-8871-72f6c272cd61	false	require.password.update.after.registration
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
6448f21f-8a1c-4e6b-9dfd-d39b4e9d7284	t	t	master-realm	0	f	7ae6d9cc-55f9-468b-9fd5-798423525454	\N	t	\N	f	master	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
59dce76d-31c7-4e34-8ad9-b4482633e358	t	f	account	0	f	b8d8ed8d-0309-4cd7-b6de-1e49d92b854a	/realms/master/account/	f	\N	f	master	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
7c9b3b6d-b482-4861-9ba5-48c2a9dcd034	t	f	account-console	0	t	6dacd433-b91d-40c6-888d-64efa128a015	/realms/master/account/	f	\N	f	master	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
4a060085-95bc-4723-9d60-3ac63484f919	t	f	broker	0	f	2e5341d9-5428-4333-9d8d-c79127c64176	\N	f	\N	f	master	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
5373b568-d117-4882-8325-1dc15d4cbdaf	t	f	security-admin-console	0	t	75166554-63f9-474d-876e-7709a7ee111e	/admin/master/console/	f	\N	f	master	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
328db07a-61b1-4978-bcbc-e51ac75f6fe9	t	f	admin-cli	0	t	38052714-da05-453c-87ea-b6887ea21973	\N	f	\N	f	master	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
2c921c55-45b9-47e6-b5d4-1dc65f009a7a	t	t	express-node	0	t	43681d08-d157-4f75-a0c7-c0d066e49c46	\N	f	https://express-openid-client/	f	master	openid-connect	-1	f	f	\N	f	client-secret	https://express-openid-client/	\N	\N	t	t	t	f
6bd6e1fa-3c19-4bde-a5d4-17e8b5f2c5af	t	t	angular-oauth2-oidc-client	0	t	41f9971a-4d86-4b73-961b-c1388e3a206c	\N	f	https://angular-oauth2-oidc-client/	f	master	openid-connect	-1	f	f	\N	f	client-secret	https://angular-oauth2-oidc-client/	\N	\N	t	t	t	f
7c6ca6bc-d284-4513-92cf-18b5e44ce99d	t	t	angular-auth-oidc	0	t	68964bfd-7659-47de-b540-32116ddf18a6	\N	f	https://angular-auth-oidc-client/	f	master	openid-connect	-1	f	f	\N	f	client-secret	https://angular-auth-oidc-client/	\N	\N	t	t	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_attributes (client_id, value, name) FROM stdin;
7c9b3b6d-b482-4861-9ba5-48c2a9dcd034	S256	pkce.code.challenge.method
5373b568-d117-4882-8325-1dc15d4cbdaf	S256	pkce.code.challenge.method
2c921c55-45b9-47e6-b5d4-1dc65f009a7a	false	saml.server.signature
2c921c55-45b9-47e6-b5d4-1dc65f009a7a	false	saml.server.signature.keyinfo.ext
2c921c55-45b9-47e6-b5d4-1dc65f009a7a	false	saml.assertion.signature
2c921c55-45b9-47e6-b5d4-1dc65f009a7a	false	saml.client.signature
2c921c55-45b9-47e6-b5d4-1dc65f009a7a	false	saml.encrypt
2c921c55-45b9-47e6-b5d4-1dc65f009a7a	false	saml.authnstatement
2c921c55-45b9-47e6-b5d4-1dc65f009a7a	false	saml.onetimeuse.condition
2c921c55-45b9-47e6-b5d4-1dc65f009a7a	false	saml_force_name_id_format
2c921c55-45b9-47e6-b5d4-1dc65f009a7a	false	saml.multivalued.roles
2c921c55-45b9-47e6-b5d4-1dc65f009a7a	false	saml.force.post.binding
2c921c55-45b9-47e6-b5d4-1dc65f009a7a	false	exclude.session.state.from.auth.response
2c921c55-45b9-47e6-b5d4-1dc65f009a7a	false	tls.client.certificate.bound.access.tokens
2c921c55-45b9-47e6-b5d4-1dc65f009a7a	false	display.on.consent.screen
6bd6e1fa-3c19-4bde-a5d4-17e8b5f2c5af	false	saml.server.signature
6bd6e1fa-3c19-4bde-a5d4-17e8b5f2c5af	false	saml.server.signature.keyinfo.ext
6bd6e1fa-3c19-4bde-a5d4-17e8b5f2c5af	false	saml.assertion.signature
6bd6e1fa-3c19-4bde-a5d4-17e8b5f2c5af	false	saml.client.signature
6bd6e1fa-3c19-4bde-a5d4-17e8b5f2c5af	false	saml.encrypt
6bd6e1fa-3c19-4bde-a5d4-17e8b5f2c5af	false	saml.authnstatement
6bd6e1fa-3c19-4bde-a5d4-17e8b5f2c5af	false	saml.onetimeuse.condition
6bd6e1fa-3c19-4bde-a5d4-17e8b5f2c5af	false	saml_force_name_id_format
6bd6e1fa-3c19-4bde-a5d4-17e8b5f2c5af	false	saml.multivalued.roles
6bd6e1fa-3c19-4bde-a5d4-17e8b5f2c5af	false	saml.force.post.binding
6bd6e1fa-3c19-4bde-a5d4-17e8b5f2c5af	false	exclude.session.state.from.auth.response
6bd6e1fa-3c19-4bde-a5d4-17e8b5f2c5af	false	tls.client.certificate.bound.access.tokens
6bd6e1fa-3c19-4bde-a5d4-17e8b5f2c5af	false	display.on.consent.screen
7c6ca6bc-d284-4513-92cf-18b5e44ce99d	false	saml.server.signature
7c6ca6bc-d284-4513-92cf-18b5e44ce99d	false	saml.server.signature.keyinfo.ext
7c6ca6bc-d284-4513-92cf-18b5e44ce99d	false	saml.assertion.signature
7c6ca6bc-d284-4513-92cf-18b5e44ce99d	false	saml.client.signature
7c6ca6bc-d284-4513-92cf-18b5e44ce99d	false	saml.encrypt
7c6ca6bc-d284-4513-92cf-18b5e44ce99d	false	saml.authnstatement
7c6ca6bc-d284-4513-92cf-18b5e44ce99d	false	saml.onetimeuse.condition
7c6ca6bc-d284-4513-92cf-18b5e44ce99d	false	saml_force_name_id_format
7c6ca6bc-d284-4513-92cf-18b5e44ce99d	false	saml.multivalued.roles
7c6ca6bc-d284-4513-92cf-18b5e44ce99d	false	saml.force.post.binding
7c6ca6bc-d284-4513-92cf-18b5e44ce99d	false	exclude.session.state.from.auth.response
7c6ca6bc-d284-4513-92cf-18b5e44ce99d	false	tls.client.certificate.bound.access.tokens
7c6ca6bc-d284-4513-92cf-18b5e44ce99d	false	display.on.consent.screen
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_default_roles; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_default_roles (client_id, role_id) FROM stdin;
59dce76d-31c7-4e34-8ad9-b4482633e358	7a1406bd-bd81-451d-a11b-827f5190e155
59dce76d-31c7-4e34-8ad9-b4482633e358	02d796c9-9416-4a2c-8c0a-390e38cd4f86
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
75a527c6-eed6-4100-a465-ef6bcf098264	offline_access	master	OpenID Connect built-in scope: offline_access	openid-connect
b57d35ad-76af-46d7-988f-6a7237d821df	role_list	master	SAML role list	saml
ee056d72-8659-40b6-9a4e-cdb5ecc73c8a	profile	master	OpenID Connect built-in scope: profile	openid-connect
e6637610-efc7-4bd4-aa0a-60dd1040ff3c	email	master	OpenID Connect built-in scope: email	openid-connect
4327a8a4-e647-44fc-8523-c62f8f03ca49	address	master	OpenID Connect built-in scope: address	openid-connect
a4556a96-c05e-4d42-aad2-9d502b18e131	phone	master	OpenID Connect built-in scope: phone	openid-connect
da60f342-fa2d-4ef5-8fda-ad9d8b45963e	roles	master	OpenID Connect scope for add user roles to the access token	openid-connect
32397e1a-798c-4bcb-b827-da16036d32b9	web-origins	master	OpenID Connect scope for add allowed web origins to the access token	openid-connect
40bb10bc-9071-4447-a313-d41f753f7954	microprofile-jwt	master	Microprofile - JWT built-in scope	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
75a527c6-eed6-4100-a465-ef6bcf098264	true	display.on.consent.screen
75a527c6-eed6-4100-a465-ef6bcf098264	${offlineAccessScopeConsentText}	consent.screen.text
b57d35ad-76af-46d7-988f-6a7237d821df	true	display.on.consent.screen
b57d35ad-76af-46d7-988f-6a7237d821df	${samlRoleListScopeConsentText}	consent.screen.text
ee056d72-8659-40b6-9a4e-cdb5ecc73c8a	true	display.on.consent.screen
ee056d72-8659-40b6-9a4e-cdb5ecc73c8a	${profileScopeConsentText}	consent.screen.text
ee056d72-8659-40b6-9a4e-cdb5ecc73c8a	true	include.in.token.scope
e6637610-efc7-4bd4-aa0a-60dd1040ff3c	true	display.on.consent.screen
e6637610-efc7-4bd4-aa0a-60dd1040ff3c	${emailScopeConsentText}	consent.screen.text
e6637610-efc7-4bd4-aa0a-60dd1040ff3c	true	include.in.token.scope
4327a8a4-e647-44fc-8523-c62f8f03ca49	true	display.on.consent.screen
4327a8a4-e647-44fc-8523-c62f8f03ca49	${addressScopeConsentText}	consent.screen.text
4327a8a4-e647-44fc-8523-c62f8f03ca49	true	include.in.token.scope
a4556a96-c05e-4d42-aad2-9d502b18e131	true	display.on.consent.screen
a4556a96-c05e-4d42-aad2-9d502b18e131	${phoneScopeConsentText}	consent.screen.text
a4556a96-c05e-4d42-aad2-9d502b18e131	true	include.in.token.scope
da60f342-fa2d-4ef5-8fda-ad9d8b45963e	true	display.on.consent.screen
da60f342-fa2d-4ef5-8fda-ad9d8b45963e	${rolesScopeConsentText}	consent.screen.text
da60f342-fa2d-4ef5-8fda-ad9d8b45963e	false	include.in.token.scope
32397e1a-798c-4bcb-b827-da16036d32b9	false	display.on.consent.screen
32397e1a-798c-4bcb-b827-da16036d32b9		consent.screen.text
32397e1a-798c-4bcb-b827-da16036d32b9	false	include.in.token.scope
40bb10bc-9071-4447-a313-d41f753f7954	false	display.on.consent.screen
40bb10bc-9071-4447-a313-d41f753f7954	true	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
59dce76d-31c7-4e34-8ad9-b4482633e358	b57d35ad-76af-46d7-988f-6a7237d821df	t
7c9b3b6d-b482-4861-9ba5-48c2a9dcd034	b57d35ad-76af-46d7-988f-6a7237d821df	t
328db07a-61b1-4978-bcbc-e51ac75f6fe9	b57d35ad-76af-46d7-988f-6a7237d821df	t
4a060085-95bc-4723-9d60-3ac63484f919	b57d35ad-76af-46d7-988f-6a7237d821df	t
6448f21f-8a1c-4e6b-9dfd-d39b4e9d7284	b57d35ad-76af-46d7-988f-6a7237d821df	t
5373b568-d117-4882-8325-1dc15d4cbdaf	b57d35ad-76af-46d7-988f-6a7237d821df	t
59dce76d-31c7-4e34-8ad9-b4482633e358	ee056d72-8659-40b6-9a4e-cdb5ecc73c8a	t
59dce76d-31c7-4e34-8ad9-b4482633e358	e6637610-efc7-4bd4-aa0a-60dd1040ff3c	t
59dce76d-31c7-4e34-8ad9-b4482633e358	da60f342-fa2d-4ef5-8fda-ad9d8b45963e	t
59dce76d-31c7-4e34-8ad9-b4482633e358	32397e1a-798c-4bcb-b827-da16036d32b9	t
59dce76d-31c7-4e34-8ad9-b4482633e358	75a527c6-eed6-4100-a465-ef6bcf098264	f
59dce76d-31c7-4e34-8ad9-b4482633e358	4327a8a4-e647-44fc-8523-c62f8f03ca49	f
59dce76d-31c7-4e34-8ad9-b4482633e358	a4556a96-c05e-4d42-aad2-9d502b18e131	f
59dce76d-31c7-4e34-8ad9-b4482633e358	40bb10bc-9071-4447-a313-d41f753f7954	f
7c9b3b6d-b482-4861-9ba5-48c2a9dcd034	ee056d72-8659-40b6-9a4e-cdb5ecc73c8a	t
7c9b3b6d-b482-4861-9ba5-48c2a9dcd034	e6637610-efc7-4bd4-aa0a-60dd1040ff3c	t
7c9b3b6d-b482-4861-9ba5-48c2a9dcd034	da60f342-fa2d-4ef5-8fda-ad9d8b45963e	t
7c9b3b6d-b482-4861-9ba5-48c2a9dcd034	32397e1a-798c-4bcb-b827-da16036d32b9	t
7c9b3b6d-b482-4861-9ba5-48c2a9dcd034	75a527c6-eed6-4100-a465-ef6bcf098264	f
7c9b3b6d-b482-4861-9ba5-48c2a9dcd034	4327a8a4-e647-44fc-8523-c62f8f03ca49	f
7c9b3b6d-b482-4861-9ba5-48c2a9dcd034	a4556a96-c05e-4d42-aad2-9d502b18e131	f
7c9b3b6d-b482-4861-9ba5-48c2a9dcd034	40bb10bc-9071-4447-a313-d41f753f7954	f
328db07a-61b1-4978-bcbc-e51ac75f6fe9	ee056d72-8659-40b6-9a4e-cdb5ecc73c8a	t
328db07a-61b1-4978-bcbc-e51ac75f6fe9	e6637610-efc7-4bd4-aa0a-60dd1040ff3c	t
328db07a-61b1-4978-bcbc-e51ac75f6fe9	da60f342-fa2d-4ef5-8fda-ad9d8b45963e	t
328db07a-61b1-4978-bcbc-e51ac75f6fe9	32397e1a-798c-4bcb-b827-da16036d32b9	t
328db07a-61b1-4978-bcbc-e51ac75f6fe9	75a527c6-eed6-4100-a465-ef6bcf098264	f
328db07a-61b1-4978-bcbc-e51ac75f6fe9	4327a8a4-e647-44fc-8523-c62f8f03ca49	f
328db07a-61b1-4978-bcbc-e51ac75f6fe9	a4556a96-c05e-4d42-aad2-9d502b18e131	f
328db07a-61b1-4978-bcbc-e51ac75f6fe9	40bb10bc-9071-4447-a313-d41f753f7954	f
4a060085-95bc-4723-9d60-3ac63484f919	ee056d72-8659-40b6-9a4e-cdb5ecc73c8a	t
4a060085-95bc-4723-9d60-3ac63484f919	e6637610-efc7-4bd4-aa0a-60dd1040ff3c	t
4a060085-95bc-4723-9d60-3ac63484f919	da60f342-fa2d-4ef5-8fda-ad9d8b45963e	t
4a060085-95bc-4723-9d60-3ac63484f919	32397e1a-798c-4bcb-b827-da16036d32b9	t
4a060085-95bc-4723-9d60-3ac63484f919	75a527c6-eed6-4100-a465-ef6bcf098264	f
4a060085-95bc-4723-9d60-3ac63484f919	4327a8a4-e647-44fc-8523-c62f8f03ca49	f
4a060085-95bc-4723-9d60-3ac63484f919	a4556a96-c05e-4d42-aad2-9d502b18e131	f
4a060085-95bc-4723-9d60-3ac63484f919	40bb10bc-9071-4447-a313-d41f753f7954	f
6448f21f-8a1c-4e6b-9dfd-d39b4e9d7284	ee056d72-8659-40b6-9a4e-cdb5ecc73c8a	t
6448f21f-8a1c-4e6b-9dfd-d39b4e9d7284	e6637610-efc7-4bd4-aa0a-60dd1040ff3c	t
6448f21f-8a1c-4e6b-9dfd-d39b4e9d7284	da60f342-fa2d-4ef5-8fda-ad9d8b45963e	t
6448f21f-8a1c-4e6b-9dfd-d39b4e9d7284	32397e1a-798c-4bcb-b827-da16036d32b9	t
6448f21f-8a1c-4e6b-9dfd-d39b4e9d7284	75a527c6-eed6-4100-a465-ef6bcf098264	f
6448f21f-8a1c-4e6b-9dfd-d39b4e9d7284	4327a8a4-e647-44fc-8523-c62f8f03ca49	f
6448f21f-8a1c-4e6b-9dfd-d39b4e9d7284	a4556a96-c05e-4d42-aad2-9d502b18e131	f
6448f21f-8a1c-4e6b-9dfd-d39b4e9d7284	40bb10bc-9071-4447-a313-d41f753f7954	f
5373b568-d117-4882-8325-1dc15d4cbdaf	ee056d72-8659-40b6-9a4e-cdb5ecc73c8a	t
5373b568-d117-4882-8325-1dc15d4cbdaf	e6637610-efc7-4bd4-aa0a-60dd1040ff3c	t
5373b568-d117-4882-8325-1dc15d4cbdaf	da60f342-fa2d-4ef5-8fda-ad9d8b45963e	t
5373b568-d117-4882-8325-1dc15d4cbdaf	32397e1a-798c-4bcb-b827-da16036d32b9	t
5373b568-d117-4882-8325-1dc15d4cbdaf	75a527c6-eed6-4100-a465-ef6bcf098264	f
5373b568-d117-4882-8325-1dc15d4cbdaf	4327a8a4-e647-44fc-8523-c62f8f03ca49	f
5373b568-d117-4882-8325-1dc15d4cbdaf	a4556a96-c05e-4d42-aad2-9d502b18e131	f
5373b568-d117-4882-8325-1dc15d4cbdaf	40bb10bc-9071-4447-a313-d41f753f7954	f
2c921c55-45b9-47e6-b5d4-1dc65f009a7a	b57d35ad-76af-46d7-988f-6a7237d821df	t
2c921c55-45b9-47e6-b5d4-1dc65f009a7a	ee056d72-8659-40b6-9a4e-cdb5ecc73c8a	t
2c921c55-45b9-47e6-b5d4-1dc65f009a7a	e6637610-efc7-4bd4-aa0a-60dd1040ff3c	t
2c921c55-45b9-47e6-b5d4-1dc65f009a7a	da60f342-fa2d-4ef5-8fda-ad9d8b45963e	t
2c921c55-45b9-47e6-b5d4-1dc65f009a7a	32397e1a-798c-4bcb-b827-da16036d32b9	t
2c921c55-45b9-47e6-b5d4-1dc65f009a7a	75a527c6-eed6-4100-a465-ef6bcf098264	f
2c921c55-45b9-47e6-b5d4-1dc65f009a7a	4327a8a4-e647-44fc-8523-c62f8f03ca49	f
2c921c55-45b9-47e6-b5d4-1dc65f009a7a	a4556a96-c05e-4d42-aad2-9d502b18e131	f
2c921c55-45b9-47e6-b5d4-1dc65f009a7a	40bb10bc-9071-4447-a313-d41f753f7954	f
6bd6e1fa-3c19-4bde-a5d4-17e8b5f2c5af	b57d35ad-76af-46d7-988f-6a7237d821df	t
6bd6e1fa-3c19-4bde-a5d4-17e8b5f2c5af	ee056d72-8659-40b6-9a4e-cdb5ecc73c8a	t
6bd6e1fa-3c19-4bde-a5d4-17e8b5f2c5af	e6637610-efc7-4bd4-aa0a-60dd1040ff3c	t
6bd6e1fa-3c19-4bde-a5d4-17e8b5f2c5af	da60f342-fa2d-4ef5-8fda-ad9d8b45963e	t
6bd6e1fa-3c19-4bde-a5d4-17e8b5f2c5af	32397e1a-798c-4bcb-b827-da16036d32b9	t
6bd6e1fa-3c19-4bde-a5d4-17e8b5f2c5af	75a527c6-eed6-4100-a465-ef6bcf098264	f
6bd6e1fa-3c19-4bde-a5d4-17e8b5f2c5af	4327a8a4-e647-44fc-8523-c62f8f03ca49	f
6bd6e1fa-3c19-4bde-a5d4-17e8b5f2c5af	a4556a96-c05e-4d42-aad2-9d502b18e131	f
6bd6e1fa-3c19-4bde-a5d4-17e8b5f2c5af	40bb10bc-9071-4447-a313-d41f753f7954	f
7c6ca6bc-d284-4513-92cf-18b5e44ce99d	b57d35ad-76af-46d7-988f-6a7237d821df	t
7c6ca6bc-d284-4513-92cf-18b5e44ce99d	ee056d72-8659-40b6-9a4e-cdb5ecc73c8a	t
7c6ca6bc-d284-4513-92cf-18b5e44ce99d	e6637610-efc7-4bd4-aa0a-60dd1040ff3c	t
7c6ca6bc-d284-4513-92cf-18b5e44ce99d	da60f342-fa2d-4ef5-8fda-ad9d8b45963e	t
7c6ca6bc-d284-4513-92cf-18b5e44ce99d	32397e1a-798c-4bcb-b827-da16036d32b9	t
7c6ca6bc-d284-4513-92cf-18b5e44ce99d	75a527c6-eed6-4100-a465-ef6bcf098264	f
7c6ca6bc-d284-4513-92cf-18b5e44ce99d	4327a8a4-e647-44fc-8523-c62f8f03ca49	f
7c6ca6bc-d284-4513-92cf-18b5e44ce99d	a4556a96-c05e-4d42-aad2-9d502b18e131	f
7c6ca6bc-d284-4513-92cf-18b5e44ce99d	40bb10bc-9071-4447-a313-d41f753f7954	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
75a527c6-eed6-4100-a465-ef6bcf098264	5ee7e070-cbc6-4765-880a-6c7bf9e4bc26
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
7e78fc16-34f1-463e-89a0-68bb9cb3d8a1	Full Scope Disabled	master	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
6a1ead65-1849-4f34-8520-3401fcb86eb5	Max Clients Limit	master	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
2f95cede-beeb-4889-963d-132764153441	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
cc4c6db1-9aad-41ef-ae89-c21fc4fc5af0	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
2164886f-e03d-4bf5-b81f-70576373f96d	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
bf5a410c-3213-4b1a-ab7a-faf0de1c7ec6	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
54f01621-a1ac-4186-8018-5a909a08cd75	rsa-generated	master	rsa-generated	org.keycloak.keys.KeyProvider	master	\N
292e765f-1366-47e8-8482-45556d47a41b	hmac-generated	master	hmac-generated	org.keycloak.keys.KeyProvider	master	\N
26878304-297c-43b0-8cd4-8729349f2f7f	aes-generated	master	aes-generated	org.keycloak.keys.KeyProvider	master	\N
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
cc4a6eaf-29c3-48f9-bb6e-6291c39bdcf0	2f95cede-beeb-4889-963d-132764153441	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
07bb5496-9ba7-4404-8ac9-380b25be6d02	2f95cede-beeb-4889-963d-132764153441	allowed-protocol-mapper-types	oidc-full-name-mapper
f1d3ab66-8ef9-4908-bb9c-e9779db371fd	2f95cede-beeb-4889-963d-132764153441	allowed-protocol-mapper-types	oidc-address-mapper
c96965e5-1597-49ba-baf6-3704f74f26ea	2f95cede-beeb-4889-963d-132764153441	allowed-protocol-mapper-types	saml-role-list-mapper
f18fdb71-3595-4f0f-bebc-e84aa51d92d1	2f95cede-beeb-4889-963d-132764153441	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
718e8480-6717-49de-83b1-122f259f2965	2f95cede-beeb-4889-963d-132764153441	allowed-protocol-mapper-types	saml-user-attribute-mapper
e475f638-4f1d-49a2-ab3c-0069941e558e	2f95cede-beeb-4889-963d-132764153441	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
3379038b-92ae-44fc-a5b5-a4731102063a	2f95cede-beeb-4889-963d-132764153441	allowed-protocol-mapper-types	saml-user-property-mapper
9be97401-7f32-42f3-97ef-a88dcdc8b539	6a1ead65-1849-4f34-8520-3401fcb86eb5	max-clients	200
4db1e9d5-09d4-4337-8aee-a16c2e8794a6	cc4c6db1-9aad-41ef-ae89-c21fc4fc5af0	allow-default-scopes	true
ddc34a5f-771a-4de6-a634-5540af6e2484	bf5a410c-3213-4b1a-ab7a-faf0de1c7ec6	allow-default-scopes	true
9d5d3a68-1663-40a4-99a4-6555d5b23345	2164886f-e03d-4bf5-b81f-70576373f96d	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
c256845a-8fc5-4e30-8941-80ebf8540166	2164886f-e03d-4bf5-b81f-70576373f96d	allowed-protocol-mapper-types	oidc-address-mapper
b4a18940-3f9f-4ece-b279-ca67e05c29cd	2164886f-e03d-4bf5-b81f-70576373f96d	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
9addbf2d-b0a3-4524-a999-81deb4bd9c58	2164886f-e03d-4bf5-b81f-70576373f96d	allowed-protocol-mapper-types	saml-user-attribute-mapper
4bfd9f09-d956-42aa-a826-fb8299068ab1	2164886f-e03d-4bf5-b81f-70576373f96d	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
36627fb3-cac5-4a37-8c71-c934c94b3076	2164886f-e03d-4bf5-b81f-70576373f96d	allowed-protocol-mapper-types	saml-user-property-mapper
7558ac3b-61e2-4b8e-9faf-8699fbad00d4	2164886f-e03d-4bf5-b81f-70576373f96d	allowed-protocol-mapper-types	saml-role-list-mapper
7253416c-0ef4-44c4-a62d-869e46302fe4	2164886f-e03d-4bf5-b81f-70576373f96d	allowed-protocol-mapper-types	oidc-full-name-mapper
b67074e9-4c44-410e-b377-bea60d188dba	292e765f-1366-47e8-8482-45556d47a41b	algorithm	HS256
5fd91caf-1531-4e8b-94bd-79079a12cb3b	292e765f-1366-47e8-8482-45556d47a41b	kid	515d59f1-ebba-4202-9158-d365b53b4a2f
97bf1951-07d9-497a-bee3-453643ccce14	292e765f-1366-47e8-8482-45556d47a41b	priority	100
17d231e7-283d-4e82-861b-fc4dbc7f8ba4	292e765f-1366-47e8-8482-45556d47a41b	secret	HyuiEKa-pDeDy7RF01YavxNSXu83SorV23E502US2JMUxyfIvQgxrqcJ70Mi0PGiBvFliNuQoY62j5U8sLhWQw
92015b5c-d575-466a-9336-82f5644c29bb	54f01621-a1ac-4186-8018-5a909a08cd75	certificate	MIICmzCCAYMCBgFxnWMWVzANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjAwNDIxMTUzNTQ4WhcNMzAwNDIxMTUzNzI4WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCnrc4/N1XMzmkHFgkj4sqH6bESu3CO5OnwLsBtZWx+YrNrMkSBSYrBaOxor7PaokCF6YAh8eCMYGpmegL0QN/B6DPbite1JTe/JcwpSobpmXuniOB3co6FIQSUx7y5mVCsA2stpuxGuKpPFpR/kfnsmU8OPASmSN+8Yw66HMsMpZVlZU3oxivWc0/C/24pkmzzvbW9d8cCc3Ku+7kFQ8aXC27UkOJDqlFEyJ9NTewA56IMgZhrJ7t7N7K2Xsg9ho52NGx5doC72JmeaY+Zko4FesFv2e/lblChpLdA4hYn3A4R3N3U3szSJJJKQe2Q/8StQOAXzh2VUI8f9kO3PeLBAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAJn2Wu4BPQ/kmKccs2xPKfBssd/8orYDm45dQlMRZv7eObmn9nTWqiPHAzAzQGhM/Nrq6QRoA7OB/YkmLxK3NDhnSwncDNNFm7P+wWTXBc343g9EnwmJ7qHIOWlgMQXU41ME++5jTXooFpueOvP9FFl2Xj3pFZpZVAFyxbsppZpfgGPPH/m9xCozNWFYL+o/ibEprtqZj/TJiZJuUd11GOCet91SIi62gbcYlUdOiAwSNbK39100kmoIqiISpaDVx8fPxT3SlFMtFn9H7ouiaP4/3HGUDGu0TJYuGlJPx+Neo72cNawzpUnqKUQY38H9RAG53EG2H7dYXGngSirYXn8=
74d42fb0-5fc5-456b-9db7-eb6ec5fe7efd	54f01621-a1ac-4186-8018-5a909a08cd75	privateKey	MIIEowIBAAKCAQEAp63OPzdVzM5pBxYJI+LKh+mxErtwjuTp8C7AbWVsfmKzazJEgUmKwWjsaK+z2qJAhemAIfHgjGBqZnoC9EDfwegz24rXtSU3vyXMKUqG6Zl7p4jgd3KOhSEElMe8uZlQrANrLabsRriqTxaUf5H57JlPDjwEpkjfvGMOuhzLDKWVZWVN6MYr1nNPwv9uKZJs8721vXfHAnNyrvu5BUPGlwtu1JDiQ6pRRMifTU3sAOeiDIGYaye7ezeytl7IPYaOdjRseXaAu9iZnmmPmZKOBXrBb9nv5W5QoaS3QOIWJ9wOEdzd1N7M0iSSSkHtkP/ErUDgF84dlVCPH/ZDtz3iwQIDAQABAoIBAF+5o7MHPh5MAD2hYNpx0LnCueo9w8Zv/PW3WveZHVURt+gMrHs6ptI/uicRl5XLZxaL9TBry4uYR2X1ZdZXauZiT6iYHQk3FBo109YGy/p0OtmsFKlcZuytqtXdKWqzkhCBayCG2QCOz/uSongpuApQg4dW0Di2BbSgwHmTkn/G4w0m/bkJ0z84ss48ryRr5bmy+wRZcckQLIJXQYJcksG79Ihu0JVxF95aCg6yDuxyPtxOVMi5jzKJBgynDLwFeFDh7oEhn1JMCo0p7Qk6fYJME/gsdbtZD2JoK4uwKPhcTFpysFw5yfsCFscTAVDysEKJQMcdrqdrXu3DsTZuAgECgYEA23VUpge0gRDlPM0b7zdfOkzSRyUpXJTq9bN3Suyd4KVzm8F+72H1AJ0PZ2E4ZG97XZyPeHMBcoxV5oWK3/TyNjPNR2I94JcVS+cnHNHAE5qxalWpjhytZ/HwqQDb1eSlRkwOeUJBdooBnNsyU70Y0t3fqyqMqoBkx6yZst/q1RECgYEAw5lRPd0Mfgd5gXjM1pbR7QbmQRkMiV2Tue5CJ+/2ethTgjH2AuQa9MefiwnD9SNcx+4R1q4x6t0eJKomIRvbPjOGozqp6xFnRJ73Rt9A76mTJZ3cQz3AoVZ+55B6mA9lHKdkQyl80hv9Oz7L4uCIeIAYAwsgUgaNSKPpJGcPcrECgYEAlDrZ5BMMPqkUzU6U8azq60v8NAXLvDbxxOdlSfwsXxIh1jCJ9lKp07JCN0eZeW07XG1lEqxLa/2R/9Rvivm9qBKxMugOd2ZVAiGtb2/VVuiDsRkPH2gLUExAi0aDNiPr5mF03T59TP3GPRZpFdqBq9wlOU3SGVADwkK4xfMsgKECgYA3ZjtObEdXgsJ1W0OZG8qFecjJc1DLr0diCAuQyDRlgtPUMlZdZ0IDRm73sGJiEgv7TICc72WQAeTBubdm9T7ZlTpzDPCHdbxsASJEXoND3iGhK97w5JKkn5z99Tvjyah3vyl0pFGIKQlGOHkC31mH16/1XLdgxB5MDrC/8Li9YQKBgBl0HzvQUjugR0IJIGaZy87ZrrIqqCcI6h8cA9fOd4wObrmXXGDBxOcTJV9bvxbIzNKw1hfDQBZy2X8VfqEiuFuOAghGRoquWEBH870Fbf2A2G7ynSVPi65nzrGcUVnEMNIuFo8C6sz+3OmAZqsXsaDXlmQPmWx3TIly1ka+GOsZ
212198c9-c571-4d6b-aac2-fe9f2c31a0f4	54f01621-a1ac-4186-8018-5a909a08cd75	priority	100
d0585371-6517-446c-8a22-130b9cb653ee	26878304-297c-43b0-8cd4-8729349f2f7f	priority	100
a2974734-cc1e-48ba-8cd9-020da6cf97cf	26878304-297c-43b0-8cd4-8729349f2f7f	kid	334bcc16-af8f-471c-9138-3a4851f532fd
afefc752-9355-414f-bf78-e4804680bf6c	26878304-297c-43b0-8cd4-8729349f2f7f	secret	W7sFrX69XPPGbpFBfC1g8Q
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.composite_role (composite, child_role) FROM stdin;
9d8d0dfe-b2b8-40d9-8056-6e69e0b67712	e2acbf4c-83ff-4cdc-a238-d2760ee77626
9d8d0dfe-b2b8-40d9-8056-6e69e0b67712	2e8ec7ac-a907-4bb2-9429-3e2eaa2dbd8e
9d8d0dfe-b2b8-40d9-8056-6e69e0b67712	171ca01e-462f-4233-bab3-29df9a18fea8
9d8d0dfe-b2b8-40d9-8056-6e69e0b67712	71bce1e0-e628-4adc-9bc3-e606db64dc8e
9d8d0dfe-b2b8-40d9-8056-6e69e0b67712	c911dc1f-758e-4361-880b-5266b372f616
9d8d0dfe-b2b8-40d9-8056-6e69e0b67712	4567d012-3934-4fdf-9fc8-b48287ae32d1
9d8d0dfe-b2b8-40d9-8056-6e69e0b67712	56f0110d-3730-4a0a-b80b-b33ef2e969a5
9d8d0dfe-b2b8-40d9-8056-6e69e0b67712	45d5be1c-bc45-4302-873c-fca1b4eb4501
9d8d0dfe-b2b8-40d9-8056-6e69e0b67712	1bdbbbd6-cd14-421e-977d-603a2cf1463f
9d8d0dfe-b2b8-40d9-8056-6e69e0b67712	fd87f973-859e-4e27-9323-8f0f0e6e8955
9d8d0dfe-b2b8-40d9-8056-6e69e0b67712	a693ee0e-fc27-4670-8442-2ccb3f490f2f
9d8d0dfe-b2b8-40d9-8056-6e69e0b67712	99ba3543-b0a4-4ad8-b4e7-1a66d5e85dcc
9d8d0dfe-b2b8-40d9-8056-6e69e0b67712	c9dc4bd8-b982-41c5-923a-f84e2a17b520
9d8d0dfe-b2b8-40d9-8056-6e69e0b67712	7de311aa-2926-4733-959f-48fcd3acdae2
9d8d0dfe-b2b8-40d9-8056-6e69e0b67712	e3141b07-74ee-4f74-b613-b527ad810bd5
9d8d0dfe-b2b8-40d9-8056-6e69e0b67712	406216d6-6203-4a16-ade8-a0149498c9cd
9d8d0dfe-b2b8-40d9-8056-6e69e0b67712	90da15e7-81be-4de1-9644-fbe1e3fc2092
9d8d0dfe-b2b8-40d9-8056-6e69e0b67712	4c08edf8-2d5c-479b-b20c-7f8dc7993eec
71bce1e0-e628-4adc-9bc3-e606db64dc8e	e3141b07-74ee-4f74-b613-b527ad810bd5
71bce1e0-e628-4adc-9bc3-e606db64dc8e	4c08edf8-2d5c-479b-b20c-7f8dc7993eec
c911dc1f-758e-4361-880b-5266b372f616	406216d6-6203-4a16-ade8-a0149498c9cd
02d796c9-9416-4a2c-8c0a-390e38cd4f86	d4e23706-6331-4407-998a-1b86af831daf
ea669b6d-1aaa-459f-8c14-d6ef62e44030	35b80de5-ae3a-4ee6-844d-4b04c719fe8f
9d8d0dfe-b2b8-40d9-8056-6e69e0b67712	8b82490c-bd39-47f5-bc76-feb29ac74e5b
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
910c31a9-ce9c-4638-9ef9-b41c07b0ccbc	\N	password	e31f6ba9-6c27-4725-995a-00a37a9e4a84	1587483449223	\N	{"value":"Fq+dMWOOsSfjnxKGqzmkL4ONx9Kgsgd61IK1S0xS+HgjQy2lG9jUDbD9LMgl0Z39VzrEzvtEDOtpbio6PmTajg==","salt":"9bZd1sde4tlFqbO8F11brg=="}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256"}	10
ddd3dd97-c893-4a29-9847-50a29988e464	\N	password	e8d50409-6fee-4589-a8e7-c985a6ac5cef	1587483601580	\N	{"value":"GnYNT1IxPBf7c0wC88Hbqe68nmLiNtdEE/qDExH3P2VYQMhS4NQC9y0fP9YNhpH3/MxLY5TDO78bb8jr7C/p1w==","salt":"bcemkzNJgy9k67PanvVtMA=="}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256"}	10
6c3c84bc-e8ed-4403-8a48-bfbcd82932bf	\N	password	b4095be3-9cb8-4eb6-9b5b-848192c038a5	1587483644217	\N	{"value":"uMoU7gfbYZpwaPsgjoIFR63FJnb/vQmKdxXXlaIwgCzUTE4DlCPH1i9sHT7tcqhgtYBZPq/HEd9dCpJ2jWKDaQ==","salt":"suo2EbpE+M0yMBjY24BKGA=="}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256"}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2020-04-21 15:37:25.683455	1	EXECUTED	7:4e70412f24a3f382c82183742ec79317	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	7483445541
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2020-04-21 15:37:25.690462	2	MARK_RAN	7:cb16724583e9675711801c6875114f28	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	7483445541
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2020-04-21 15:37:25.710832	3	EXECUTED	7:0310eb8ba07cec616460794d42ade0fa	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	3.5.4	\N	\N	7483445541
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2020-04-21 15:37:25.713332	4	EXECUTED	7:5d25857e708c3233ef4439df1f93f012	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	3.5.4	\N	\N	7483445541
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2020-04-21 15:37:25.755652	5	EXECUTED	7:c7a54a1041d58eb3817a4a883b4d4e84	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	7483445541
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2020-04-21 15:37:25.757731	6	MARK_RAN	7:2e01012df20974c1c2a605ef8afe25b7	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	7483445541
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2020-04-21 15:37:25.796259	7	EXECUTED	7:0f08df48468428e0f30ee59a8ec01a41	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	7483445541
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2020-04-21 15:37:25.798776	8	MARK_RAN	7:a77ea2ad226b345e7d689d366f185c8c	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	7483445541
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2020-04-21 15:37:25.801603	9	EXECUTED	7:a3377a2059aefbf3b90ebb4c4cc8e2ab	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	3.5.4	\N	\N	7483445541
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2020-04-21 15:37:25.841802	10	EXECUTED	7:04c1dbedc2aa3e9756d1a1668e003451	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	3.5.4	\N	\N	7483445541
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2020-04-21 15:37:25.864545	11	EXECUTED	7:36ef39ed560ad07062d956db861042ba	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	7483445541
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2020-04-21 15:37:25.866395	12	MARK_RAN	7:d909180b2530479a716d3f9c9eaea3d7	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	7483445541
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2020-04-21 15:37:25.874646	13	EXECUTED	7:cf12b04b79bea5152f165eb41f3955f6	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	7483445541
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2020-04-21 15:37:25.885004	14	EXECUTED	7:7e32c8f05c755e8675764e7d5f514509	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	3.5.4	\N	\N	7483445541
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2020-04-21 15:37:25.886278	15	MARK_RAN	7:980ba23cc0ec39cab731ce903dd01291	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	7483445541
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2020-04-21 15:37:25.887402	16	MARK_RAN	7:2fa220758991285312eb84f3b4ff5336	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	3.5.4	\N	\N	7483445541
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2020-04-21 15:37:25.888346	17	EXECUTED	7:d41d8cd98f00b204e9800998ecf8427e	empty		\N	3.5.4	\N	\N	7483445541
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2020-04-21 15:37:25.907165	18	EXECUTED	7:91ace540896df890cc00a0490ee52bbc	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	3.5.4	\N	\N	7483445541
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2020-04-21 15:37:25.926127	19	EXECUTED	7:c31d1646dfa2618a9335c00e07f89f24	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	7483445541
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2020-04-21 15:37:25.928682	20	EXECUTED	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	7483445541
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2020-04-21 15:37:26.11717	45	EXECUTED	7:6a48ce645a3525488a90fbf76adf3bb3	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	7483445541
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2020-04-21 15:37:25.929974	21	MARK_RAN	7:f987971fe6b37d963bc95fee2b27f8df	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	7483445541
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2020-04-21 15:37:25.931287	22	MARK_RAN	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	7483445541
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2020-04-21 15:37:25.941064	23	EXECUTED	7:ed2dc7f799d19ac452cbcda56c929e47	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	3.5.4	\N	\N	7483445541
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2020-04-21 15:37:25.943654	24	EXECUTED	7:80b5db88a5dda36ece5f235be8757615	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	7483445541
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2020-04-21 15:37:25.945078	25	MARK_RAN	7:1437310ed1305a9b93f8848f301726ce	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	7483445541
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2020-04-21 15:37:25.958386	26	EXECUTED	7:b82ffb34850fa0836be16deefc6a87c4	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	3.5.4	\N	\N	7483445541
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2020-04-21 15:37:25.98959	27	EXECUTED	7:9cc98082921330d8d9266decdd4bd658	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	3.5.4	\N	\N	7483445541
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2020-04-21 15:37:25.991492	28	EXECUTED	7:03d64aeed9cb52b969bd30a7ac0db57e	update tableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	7483445541
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2020-04-21 15:37:26.017198	29	EXECUTED	7:f1f9fd8710399d725b780f463c6b21cd	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	3.5.4	\N	\N	7483445541
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2020-04-21 15:37:26.023417	30	EXECUTED	7:53188c3eb1107546e6f765835705b6c1	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	3.5.4	\N	\N	7483445541
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2020-04-21 15:37:26.030662	31	EXECUTED	7:d6e6f3bc57a0c5586737d1351725d4d4	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	3.5.4	\N	\N	7483445541
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2020-04-21 15:37:26.032898	32	EXECUTED	7:454d604fbd755d9df3fd9c6329043aa5	customChange		\N	3.5.4	\N	\N	7483445541
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2020-04-21 15:37:26.035173	33	EXECUTED	7:57e98a3077e29caf562f7dbf80c72600	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	7483445541
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2020-04-21 15:37:26.036142	34	MARK_RAN	7:e4c7e8f2256210aee71ddc42f538b57a	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	7483445541
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2020-04-21 15:37:26.047145	35	EXECUTED	7:09a43c97e49bc626460480aa1379b522	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	7483445541
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2020-04-21 15:37:26.049696	36	EXECUTED	7:26bfc7c74fefa9126f2ce702fb775553	addColumn tableName=REALM		\N	3.5.4	\N	\N	7483445541
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2020-04-21 15:37:26.05261	37	EXECUTED	7:a161e2ae671a9020fff61e996a207377	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	7483445541
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2020-04-21 15:37:26.054544	38	EXECUTED	7:37fc1781855ac5388c494f1442b3f717	addColumn tableName=FED_USER_CONSENT		\N	3.5.4	\N	\N	7483445541
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2020-04-21 15:37:26.056175	39	EXECUTED	7:13a27db0dae6049541136adad7261d27	addColumn tableName=IDENTITY_PROVIDER		\N	3.5.4	\N	\N	7483445541
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2020-04-21 15:37:26.057025	40	MARK_RAN	7:550300617e3b59e8af3a6294df8248a3	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	7483445541
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2020-04-21 15:37:26.057891	41	MARK_RAN	7:e3a9482b8931481dc2772a5c07c44f17	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	7483445541
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2020-04-21 15:37:26.06055	42	EXECUTED	7:72b07d85a2677cb257edb02b408f332d	customChange		\N	3.5.4	\N	\N	7483445541
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2020-04-21 15:37:26.1128	43	EXECUTED	7:a72a7858967bd414835d19e04d880312	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	3.5.4	\N	\N	7483445541
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2020-04-21 15:37:26.115198	44	EXECUTED	7:94edff7cf9ce179e7e85f0cd78a3cf2c	addColumn tableName=USER_ENTITY		\N	3.5.4	\N	\N	7483445541
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2020-04-21 15:37:26.119616	46	EXECUTED	7:e64b5dcea7db06077c6e57d3b9e5ca14	customChange		\N	3.5.4	\N	\N	7483445541
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2020-04-21 15:37:26.120574	47	MARK_RAN	7:fd8cf02498f8b1e72496a20afc75178c	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	7483445541
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2020-04-21 15:37:26.135729	48	EXECUTED	7:542794f25aa2b1fbabb7e577d6646319	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	3.5.4	\N	\N	7483445541
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2020-04-21 15:37:26.137815	49	EXECUTED	7:edad604c882df12f74941dac3cc6d650	addColumn tableName=REALM		\N	3.5.4	\N	\N	7483445541
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2020-04-21 15:37:26.156039	50	EXECUTED	7:0f88b78b7b46480eb92690cbf5e44900	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	3.5.4	\N	\N	7483445541
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2020-04-21 15:37:26.168955	51	EXECUTED	7:d560e43982611d936457c327f872dd59	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	3.5.4	\N	\N	7483445541
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2020-04-21 15:37:26.171017	52	EXECUTED	7:c155566c42b4d14ef07059ec3b3bbd8e	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	7483445541
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2020-04-21 15:37:26.172231	53	EXECUTED	7:b40376581f12d70f3c89ba8ddf5b7dea	update tableName=REALM		\N	3.5.4	\N	\N	7483445541
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2020-04-21 15:37:26.173535	54	EXECUTED	7:a1132cc395f7b95b3646146c2e38f168	update tableName=CLIENT		\N	3.5.4	\N	\N	7483445541
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2020-04-21 15:37:26.176469	55	EXECUTED	7:d8dc5d89c789105cfa7ca0e82cba60af	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	3.5.4	\N	\N	7483445541
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2020-04-21 15:37:26.1794	56	EXECUTED	7:7822e0165097182e8f653c35517656a3	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	3.5.4	\N	\N	7483445541
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2020-04-21 15:37:26.188628	57	EXECUTED	7:c6538c29b9c9a08f9e9ea2de5c2b6375	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	3.5.4	\N	\N	7483445541
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2020-04-21 15:37:26.227949	58	EXECUTED	7:6d4893e36de22369cf73bcb051ded875	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	3.5.4	\N	\N	7483445541
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2020-04-21 15:37:26.239505	59	EXECUTED	7:57960fc0b0f0dd0563ea6f8b2e4a1707	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	3.5.4	\N	\N	7483445541
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2020-04-21 15:37:26.242026	60	EXECUTED	7:2b4b8bff39944c7097977cc18dbceb3b	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	7483445541
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2020-04-21 15:37:26.245988	61	EXECUTED	7:2aa42a964c59cd5b8ca9822340ba33a8	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	3.5.4	\N	\N	7483445541
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2020-04-21 15:37:26.248837	62	EXECUTED	7:9ac9e58545479929ba23f4a3087a0346	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	3.5.4	\N	\N	7483445541
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2020-04-21 15:37:26.250598	63	EXECUTED	7:14d407c35bc4fe1976867756bcea0c36	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	3.5.4	\N	\N	7483445541
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2020-04-21 15:37:26.252077	64	EXECUTED	7:241a8030c748c8548e346adee548fa93	update tableName=REQUIRED_ACTION_PROVIDER		\N	3.5.4	\N	\N	7483445541
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2020-04-21 15:37:26.253339	65	EXECUTED	7:7d3182f65a34fcc61e8d23def037dc3f	update tableName=RESOURCE_SERVER_RESOURCE		\N	3.5.4	\N	\N	7483445541
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2020-04-21 15:37:26.263554	66	EXECUTED	7:b30039e00a0b9715d430d1b0636728fa	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	3.5.4	\N	\N	7483445541
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2020-04-21 15:37:26.265895	67	EXECUTED	7:3797315ca61d531780f8e6f82f258159	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	3.5.4	\N	\N	7483445541
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2020-04-21 15:37:26.268155	68	EXECUTED	7:c7aa4c8d9573500c2d347c1941ff0301	addColumn tableName=REALM		\N	3.5.4	\N	\N	7483445541
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2020-04-21 15:37:26.272662	69	EXECUTED	7:b207faee394fc074a442ecd42185a5dd	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	3.5.4	\N	\N	7483445541
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2020-04-21 15:37:26.274898	70	EXECUTED	7:ab9a9762faaba4ddfa35514b212c4922	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	3.5.4	\N	\N	7483445541
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2020-04-21 15:37:26.27641	71	EXECUTED	7:b9710f74515a6ccb51b72dc0d19df8c4	addColumn tableName=RESOURCE_SERVER		\N	3.5.4	\N	\N	7483445541
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2020-04-21 15:37:26.279182	72	EXECUTED	7:ec9707ae4d4f0b7452fee20128083879	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	7483445541
8.0.0-updating-credential-data-not-oracle	keycloak	META-INF/jpa-changelog-8.0.0.xml	2020-04-21 15:37:26.281469	73	EXECUTED	7:03b3f4b264c3c68ba082250a80b74216	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	7483445541
8.0.0-updating-credential-data-oracle	keycloak	META-INF/jpa-changelog-8.0.0.xml	2020-04-21 15:37:26.282235	74	MARK_RAN	7:64c5728f5ca1f5aa4392217701c4fe23	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	7483445541
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2020-04-21 15:37:26.293552	75	EXECUTED	7:b48da8c11a3d83ddd6b7d0c8c2219345	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	3.5.4	\N	\N	7483445541
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2020-04-21 15:37:26.297098	76	EXECUTED	7:a73379915c23bfad3e8f5c6d5c0aa4bd	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	3.5.4	\N	\N	7483445541
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2020-04-21 15:37:26.29888	77	EXECUTED	7:39e0073779aba192646291aa2332493d	addColumn tableName=CLIENT		\N	3.5.4	\N	\N	7483445541
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2020-04-21 15:37:26.299861	78	MARK_RAN	7:81f87368f00450799b4bf42ea0b3ec34	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	3.5.4	\N	\N	7483445541
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2020-04-21 15:37:26.307791	79	EXECUTED	7:20b37422abb9fb6571c618148f013a15	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	3.5.4	\N	\N	7483445541
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2020-04-21 15:37:26.309045	80	MARK_RAN	7:1970bb6cfb5ee800736b95ad3fb3c78a	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	3.5.4	\N	\N	7483445541
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2020-04-21 15:37:26.312017	81	EXECUTED	7:45d9b25fc3b455d522d8dcc10a0f4c80	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	3.5.4	\N	\N	7483445541
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2020-04-21 15:37:26.312935	82	MARK_RAN	7:890ae73712bc187a66c2813a724d037f	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	7483445541
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2020-04-21 15:37:26.314931	83	EXECUTED	7:0a211980d27fafe3ff50d19a3a29b538	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	7483445541
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2020-04-21 15:37:26.31581	84	MARK_RAN	7:a161e2ae671a9020fff61e996a207377	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	7483445541
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2020-04-21 15:37:26.31847	85	EXECUTED	7:01c49302201bdf815b0a18d1f98a55dc	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	3.5.4	\N	\N	7483445541
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
master	75a527c6-eed6-4100-a465-ef6bcf098264	f
master	b57d35ad-76af-46d7-988f-6a7237d821df	t
master	ee056d72-8659-40b6-9a4e-cdb5ecc73c8a	t
master	e6637610-efc7-4bd4-aa0a-60dd1040ff3c	t
master	4327a8a4-e647-44fc-8523-c62f8f03ca49	f
master	a4556a96-c05e-4d42-aad2-9d502b18e131	f
master	da60f342-fa2d-4ef5-8fda-ad9d8b45963e	t
master	32397e1a-798c-4bcb-b827-da16036d32b9	t
master	40bb10bc-9071-4447-a313-d41f753f7954	f
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
9d8d0dfe-b2b8-40d9-8056-6e69e0b67712	master	f	${role_admin}	admin	master	\N	master
e2acbf4c-83ff-4cdc-a238-d2760ee77626	master	f	${role_create-realm}	create-realm	master	\N	master
2e8ec7ac-a907-4bb2-9429-3e2eaa2dbd8e	6448f21f-8a1c-4e6b-9dfd-d39b4e9d7284	t	${role_create-client}	create-client	master	6448f21f-8a1c-4e6b-9dfd-d39b4e9d7284	\N
171ca01e-462f-4233-bab3-29df9a18fea8	6448f21f-8a1c-4e6b-9dfd-d39b4e9d7284	t	${role_view-realm}	view-realm	master	6448f21f-8a1c-4e6b-9dfd-d39b4e9d7284	\N
71bce1e0-e628-4adc-9bc3-e606db64dc8e	6448f21f-8a1c-4e6b-9dfd-d39b4e9d7284	t	${role_view-users}	view-users	master	6448f21f-8a1c-4e6b-9dfd-d39b4e9d7284	\N
c911dc1f-758e-4361-880b-5266b372f616	6448f21f-8a1c-4e6b-9dfd-d39b4e9d7284	t	${role_view-clients}	view-clients	master	6448f21f-8a1c-4e6b-9dfd-d39b4e9d7284	\N
4567d012-3934-4fdf-9fc8-b48287ae32d1	6448f21f-8a1c-4e6b-9dfd-d39b4e9d7284	t	${role_view-events}	view-events	master	6448f21f-8a1c-4e6b-9dfd-d39b4e9d7284	\N
56f0110d-3730-4a0a-b80b-b33ef2e969a5	6448f21f-8a1c-4e6b-9dfd-d39b4e9d7284	t	${role_view-identity-providers}	view-identity-providers	master	6448f21f-8a1c-4e6b-9dfd-d39b4e9d7284	\N
45d5be1c-bc45-4302-873c-fca1b4eb4501	6448f21f-8a1c-4e6b-9dfd-d39b4e9d7284	t	${role_view-authorization}	view-authorization	master	6448f21f-8a1c-4e6b-9dfd-d39b4e9d7284	\N
1bdbbbd6-cd14-421e-977d-603a2cf1463f	6448f21f-8a1c-4e6b-9dfd-d39b4e9d7284	t	${role_manage-realm}	manage-realm	master	6448f21f-8a1c-4e6b-9dfd-d39b4e9d7284	\N
fd87f973-859e-4e27-9323-8f0f0e6e8955	6448f21f-8a1c-4e6b-9dfd-d39b4e9d7284	t	${role_manage-users}	manage-users	master	6448f21f-8a1c-4e6b-9dfd-d39b4e9d7284	\N
a693ee0e-fc27-4670-8442-2ccb3f490f2f	6448f21f-8a1c-4e6b-9dfd-d39b4e9d7284	t	${role_manage-clients}	manage-clients	master	6448f21f-8a1c-4e6b-9dfd-d39b4e9d7284	\N
99ba3543-b0a4-4ad8-b4e7-1a66d5e85dcc	6448f21f-8a1c-4e6b-9dfd-d39b4e9d7284	t	${role_manage-events}	manage-events	master	6448f21f-8a1c-4e6b-9dfd-d39b4e9d7284	\N
c9dc4bd8-b982-41c5-923a-f84e2a17b520	6448f21f-8a1c-4e6b-9dfd-d39b4e9d7284	t	${role_manage-identity-providers}	manage-identity-providers	master	6448f21f-8a1c-4e6b-9dfd-d39b4e9d7284	\N
7de311aa-2926-4733-959f-48fcd3acdae2	6448f21f-8a1c-4e6b-9dfd-d39b4e9d7284	t	${role_manage-authorization}	manage-authorization	master	6448f21f-8a1c-4e6b-9dfd-d39b4e9d7284	\N
e3141b07-74ee-4f74-b613-b527ad810bd5	6448f21f-8a1c-4e6b-9dfd-d39b4e9d7284	t	${role_query-users}	query-users	master	6448f21f-8a1c-4e6b-9dfd-d39b4e9d7284	\N
406216d6-6203-4a16-ade8-a0149498c9cd	6448f21f-8a1c-4e6b-9dfd-d39b4e9d7284	t	${role_query-clients}	query-clients	master	6448f21f-8a1c-4e6b-9dfd-d39b4e9d7284	\N
90da15e7-81be-4de1-9644-fbe1e3fc2092	6448f21f-8a1c-4e6b-9dfd-d39b4e9d7284	t	${role_query-realms}	query-realms	master	6448f21f-8a1c-4e6b-9dfd-d39b4e9d7284	\N
4c08edf8-2d5c-479b-b20c-7f8dc7993eec	6448f21f-8a1c-4e6b-9dfd-d39b4e9d7284	t	${role_query-groups}	query-groups	master	6448f21f-8a1c-4e6b-9dfd-d39b4e9d7284	\N
7a1406bd-bd81-451d-a11b-827f5190e155	59dce76d-31c7-4e34-8ad9-b4482633e358	t	${role_view-profile}	view-profile	master	59dce76d-31c7-4e34-8ad9-b4482633e358	\N
02d796c9-9416-4a2c-8c0a-390e38cd4f86	59dce76d-31c7-4e34-8ad9-b4482633e358	t	${role_manage-account}	manage-account	master	59dce76d-31c7-4e34-8ad9-b4482633e358	\N
d4e23706-6331-4407-998a-1b86af831daf	59dce76d-31c7-4e34-8ad9-b4482633e358	t	${role_manage-account-links}	manage-account-links	master	59dce76d-31c7-4e34-8ad9-b4482633e358	\N
9a0efcf0-c1d1-4998-90a5-2f4f71b8ddec	59dce76d-31c7-4e34-8ad9-b4482633e358	t	${role_view-applications}	view-applications	master	59dce76d-31c7-4e34-8ad9-b4482633e358	\N
35b80de5-ae3a-4ee6-844d-4b04c719fe8f	59dce76d-31c7-4e34-8ad9-b4482633e358	t	${role_view-consent}	view-consent	master	59dce76d-31c7-4e34-8ad9-b4482633e358	\N
ea669b6d-1aaa-459f-8c14-d6ef62e44030	59dce76d-31c7-4e34-8ad9-b4482633e358	t	${role_manage-consent}	manage-consent	master	59dce76d-31c7-4e34-8ad9-b4482633e358	\N
ff355384-2b9b-4bfb-8b5e-da98cb42d7a6	4a060085-95bc-4723-9d60-3ac63484f919	t	${role_read-token}	read-token	master	4a060085-95bc-4723-9d60-3ac63484f919	\N
8b82490c-bd39-47f5-bc76-feb29ac74e5b	6448f21f-8a1c-4e6b-9dfd-d39b4e9d7284	t	${role_impersonation}	impersonation	master	6448f21f-8a1c-4e6b-9dfd-d39b4e9d7284	\N
5ee7e070-cbc6-4765-880a-6c7bf9e4bc26	master	f	${role_offline-access}	offline_access	master	\N	master
cb7dadb9-3777-4acb-b427-cfc9f05db45b	master	f	${role_uma_authorization}	uma_authorization	master	\N	master
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.migration_model (id, version, update_time) FROM stdin;
rrctg	9.0.3	1587483448
wwicl	10.0.2	1591856872
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
bc36f7df-373b-4dfc-b0e1-59ab38e1c7be	audience resolve	openid-connect	oidc-audience-resolve-mapper	7c9b3b6d-b482-4861-9ba5-48c2a9dcd034	\N
38022a16-3ee0-49f2-b593-05372be666bb	locale	openid-connect	oidc-usermodel-attribute-mapper	5373b568-d117-4882-8325-1dc15d4cbdaf	\N
ae30defa-46a4-4079-bfd3-f4b453b57c67	role list	saml	saml-role-list-mapper	\N	b57d35ad-76af-46d7-988f-6a7237d821df
2d5dc416-1009-4f42-9f2f-9bd9ffebb38d	full name	openid-connect	oidc-full-name-mapper	\N	ee056d72-8659-40b6-9a4e-cdb5ecc73c8a
12edd145-141b-47d8-8f25-1436011cbbc0	family name	openid-connect	oidc-usermodel-property-mapper	\N	ee056d72-8659-40b6-9a4e-cdb5ecc73c8a
340de310-04db-4e62-bef3-ef4c4b82f4d5	given name	openid-connect	oidc-usermodel-property-mapper	\N	ee056d72-8659-40b6-9a4e-cdb5ecc73c8a
2a5cf1fa-c281-4aa4-8b03-33483f4f2756	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	ee056d72-8659-40b6-9a4e-cdb5ecc73c8a
e748d9cd-a10f-4e59-aba6-34196e776a54	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	ee056d72-8659-40b6-9a4e-cdb5ecc73c8a
dce782a5-3bf4-4ba4-889b-ffc38367c79d	username	openid-connect	oidc-usermodel-property-mapper	\N	ee056d72-8659-40b6-9a4e-cdb5ecc73c8a
206eaeac-776c-4169-bba9-b6d8ebf5cace	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	ee056d72-8659-40b6-9a4e-cdb5ecc73c8a
4ccf0fe5-f170-4284-8cf1-9d03834b966b	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	ee056d72-8659-40b6-9a4e-cdb5ecc73c8a
833adeab-f78a-418c-a2ce-6b636e5e32a3	website	openid-connect	oidc-usermodel-attribute-mapper	\N	ee056d72-8659-40b6-9a4e-cdb5ecc73c8a
7f73fac3-7c51-46ac-b19a-ea54fc60139b	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	ee056d72-8659-40b6-9a4e-cdb5ecc73c8a
c3abc415-cc99-4235-966b-4bdd03f96985	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	ee056d72-8659-40b6-9a4e-cdb5ecc73c8a
14dea47b-ea68-45e6-b1b6-b4aeaa18a4ae	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	ee056d72-8659-40b6-9a4e-cdb5ecc73c8a
1a4a5850-9e0d-452c-a59c-5b4db5148cbe	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	ee056d72-8659-40b6-9a4e-cdb5ecc73c8a
6cd14533-c75b-419c-babd-1ea5e879fa45	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	ee056d72-8659-40b6-9a4e-cdb5ecc73c8a
f9b22063-f2cf-4ff1-bf37-e173a6418b7a	email	openid-connect	oidc-usermodel-property-mapper	\N	e6637610-efc7-4bd4-aa0a-60dd1040ff3c
e7b17874-53aa-4fde-ae69-5ca74d9dcab1	email verified	openid-connect	oidc-usermodel-property-mapper	\N	e6637610-efc7-4bd4-aa0a-60dd1040ff3c
e2977dfa-f720-47c8-ba51-b816463d6b46	address	openid-connect	oidc-address-mapper	\N	4327a8a4-e647-44fc-8523-c62f8f03ca49
8438ba28-f864-4e68-b759-2547b19b035e	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	a4556a96-c05e-4d42-aad2-9d502b18e131
d94a6903-33ce-4608-ad6b-a786004d5596	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	a4556a96-c05e-4d42-aad2-9d502b18e131
c3c38d76-62d9-4756-8f2d-fe0f9aab744a	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	da60f342-fa2d-4ef5-8fda-ad9d8b45963e
bc039a7a-199f-48af-aaca-7b2f603ad845	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	da60f342-fa2d-4ef5-8fda-ad9d8b45963e
82751556-ad6c-4cc7-b1cf-45bc5c128bfc	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	da60f342-fa2d-4ef5-8fda-ad9d8b45963e
3b048f32-7cdc-4831-bd45-8a2aa999ffad	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	32397e1a-798c-4bcb-b827-da16036d32b9
0d67233c-7521-4180-8b54-e11d8a7b916b	upn	openid-connect	oidc-usermodel-property-mapper	\N	40bb10bc-9071-4447-a313-d41f753f7954
3d6d3e06-d496-4c0f-aeea-482bc997b82c	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	40bb10bc-9071-4447-a313-d41f753f7954
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
38022a16-3ee0-49f2-b593-05372be666bb	true	userinfo.token.claim
38022a16-3ee0-49f2-b593-05372be666bb	locale	user.attribute
38022a16-3ee0-49f2-b593-05372be666bb	true	id.token.claim
38022a16-3ee0-49f2-b593-05372be666bb	true	access.token.claim
38022a16-3ee0-49f2-b593-05372be666bb	locale	claim.name
38022a16-3ee0-49f2-b593-05372be666bb	String	jsonType.label
ae30defa-46a4-4079-bfd3-f4b453b57c67	false	single
ae30defa-46a4-4079-bfd3-f4b453b57c67	Basic	attribute.nameformat
ae30defa-46a4-4079-bfd3-f4b453b57c67	Role	attribute.name
2d5dc416-1009-4f42-9f2f-9bd9ffebb38d	true	userinfo.token.claim
2d5dc416-1009-4f42-9f2f-9bd9ffebb38d	true	id.token.claim
2d5dc416-1009-4f42-9f2f-9bd9ffebb38d	true	access.token.claim
12edd145-141b-47d8-8f25-1436011cbbc0	true	userinfo.token.claim
12edd145-141b-47d8-8f25-1436011cbbc0	lastName	user.attribute
12edd145-141b-47d8-8f25-1436011cbbc0	true	id.token.claim
12edd145-141b-47d8-8f25-1436011cbbc0	true	access.token.claim
12edd145-141b-47d8-8f25-1436011cbbc0	family_name	claim.name
12edd145-141b-47d8-8f25-1436011cbbc0	String	jsonType.label
340de310-04db-4e62-bef3-ef4c4b82f4d5	true	userinfo.token.claim
340de310-04db-4e62-bef3-ef4c4b82f4d5	firstName	user.attribute
340de310-04db-4e62-bef3-ef4c4b82f4d5	true	id.token.claim
340de310-04db-4e62-bef3-ef4c4b82f4d5	true	access.token.claim
340de310-04db-4e62-bef3-ef4c4b82f4d5	given_name	claim.name
340de310-04db-4e62-bef3-ef4c4b82f4d5	String	jsonType.label
2a5cf1fa-c281-4aa4-8b03-33483f4f2756	true	userinfo.token.claim
2a5cf1fa-c281-4aa4-8b03-33483f4f2756	middleName	user.attribute
2a5cf1fa-c281-4aa4-8b03-33483f4f2756	true	id.token.claim
2a5cf1fa-c281-4aa4-8b03-33483f4f2756	true	access.token.claim
2a5cf1fa-c281-4aa4-8b03-33483f4f2756	middle_name	claim.name
2a5cf1fa-c281-4aa4-8b03-33483f4f2756	String	jsonType.label
e748d9cd-a10f-4e59-aba6-34196e776a54	true	userinfo.token.claim
e748d9cd-a10f-4e59-aba6-34196e776a54	nickname	user.attribute
e748d9cd-a10f-4e59-aba6-34196e776a54	true	id.token.claim
e748d9cd-a10f-4e59-aba6-34196e776a54	true	access.token.claim
e748d9cd-a10f-4e59-aba6-34196e776a54	nickname	claim.name
e748d9cd-a10f-4e59-aba6-34196e776a54	String	jsonType.label
dce782a5-3bf4-4ba4-889b-ffc38367c79d	true	userinfo.token.claim
dce782a5-3bf4-4ba4-889b-ffc38367c79d	username	user.attribute
dce782a5-3bf4-4ba4-889b-ffc38367c79d	true	id.token.claim
dce782a5-3bf4-4ba4-889b-ffc38367c79d	true	access.token.claim
dce782a5-3bf4-4ba4-889b-ffc38367c79d	preferred_username	claim.name
dce782a5-3bf4-4ba4-889b-ffc38367c79d	String	jsonType.label
206eaeac-776c-4169-bba9-b6d8ebf5cace	true	userinfo.token.claim
206eaeac-776c-4169-bba9-b6d8ebf5cace	profile	user.attribute
206eaeac-776c-4169-bba9-b6d8ebf5cace	true	id.token.claim
206eaeac-776c-4169-bba9-b6d8ebf5cace	true	access.token.claim
206eaeac-776c-4169-bba9-b6d8ebf5cace	profile	claim.name
206eaeac-776c-4169-bba9-b6d8ebf5cace	String	jsonType.label
4ccf0fe5-f170-4284-8cf1-9d03834b966b	true	userinfo.token.claim
4ccf0fe5-f170-4284-8cf1-9d03834b966b	picture	user.attribute
4ccf0fe5-f170-4284-8cf1-9d03834b966b	true	id.token.claim
4ccf0fe5-f170-4284-8cf1-9d03834b966b	true	access.token.claim
4ccf0fe5-f170-4284-8cf1-9d03834b966b	picture	claim.name
4ccf0fe5-f170-4284-8cf1-9d03834b966b	String	jsonType.label
833adeab-f78a-418c-a2ce-6b636e5e32a3	true	userinfo.token.claim
833adeab-f78a-418c-a2ce-6b636e5e32a3	website	user.attribute
833adeab-f78a-418c-a2ce-6b636e5e32a3	true	id.token.claim
833adeab-f78a-418c-a2ce-6b636e5e32a3	true	access.token.claim
833adeab-f78a-418c-a2ce-6b636e5e32a3	website	claim.name
833adeab-f78a-418c-a2ce-6b636e5e32a3	String	jsonType.label
7f73fac3-7c51-46ac-b19a-ea54fc60139b	true	userinfo.token.claim
7f73fac3-7c51-46ac-b19a-ea54fc60139b	gender	user.attribute
7f73fac3-7c51-46ac-b19a-ea54fc60139b	true	id.token.claim
7f73fac3-7c51-46ac-b19a-ea54fc60139b	true	access.token.claim
7f73fac3-7c51-46ac-b19a-ea54fc60139b	gender	claim.name
7f73fac3-7c51-46ac-b19a-ea54fc60139b	String	jsonType.label
c3abc415-cc99-4235-966b-4bdd03f96985	true	userinfo.token.claim
c3abc415-cc99-4235-966b-4bdd03f96985	birthdate	user.attribute
c3abc415-cc99-4235-966b-4bdd03f96985	true	id.token.claim
c3abc415-cc99-4235-966b-4bdd03f96985	true	access.token.claim
c3abc415-cc99-4235-966b-4bdd03f96985	birthdate	claim.name
c3abc415-cc99-4235-966b-4bdd03f96985	String	jsonType.label
14dea47b-ea68-45e6-b1b6-b4aeaa18a4ae	true	userinfo.token.claim
14dea47b-ea68-45e6-b1b6-b4aeaa18a4ae	zoneinfo	user.attribute
14dea47b-ea68-45e6-b1b6-b4aeaa18a4ae	true	id.token.claim
14dea47b-ea68-45e6-b1b6-b4aeaa18a4ae	true	access.token.claim
14dea47b-ea68-45e6-b1b6-b4aeaa18a4ae	zoneinfo	claim.name
14dea47b-ea68-45e6-b1b6-b4aeaa18a4ae	String	jsonType.label
1a4a5850-9e0d-452c-a59c-5b4db5148cbe	true	userinfo.token.claim
1a4a5850-9e0d-452c-a59c-5b4db5148cbe	locale	user.attribute
1a4a5850-9e0d-452c-a59c-5b4db5148cbe	true	id.token.claim
1a4a5850-9e0d-452c-a59c-5b4db5148cbe	true	access.token.claim
1a4a5850-9e0d-452c-a59c-5b4db5148cbe	locale	claim.name
1a4a5850-9e0d-452c-a59c-5b4db5148cbe	String	jsonType.label
6cd14533-c75b-419c-babd-1ea5e879fa45	true	userinfo.token.claim
6cd14533-c75b-419c-babd-1ea5e879fa45	updatedAt	user.attribute
6cd14533-c75b-419c-babd-1ea5e879fa45	true	id.token.claim
6cd14533-c75b-419c-babd-1ea5e879fa45	true	access.token.claim
6cd14533-c75b-419c-babd-1ea5e879fa45	updated_at	claim.name
6cd14533-c75b-419c-babd-1ea5e879fa45	String	jsonType.label
f9b22063-f2cf-4ff1-bf37-e173a6418b7a	true	userinfo.token.claim
f9b22063-f2cf-4ff1-bf37-e173a6418b7a	email	user.attribute
f9b22063-f2cf-4ff1-bf37-e173a6418b7a	true	id.token.claim
f9b22063-f2cf-4ff1-bf37-e173a6418b7a	true	access.token.claim
f9b22063-f2cf-4ff1-bf37-e173a6418b7a	email	claim.name
f9b22063-f2cf-4ff1-bf37-e173a6418b7a	String	jsonType.label
e7b17874-53aa-4fde-ae69-5ca74d9dcab1	true	userinfo.token.claim
e7b17874-53aa-4fde-ae69-5ca74d9dcab1	emailVerified	user.attribute
e7b17874-53aa-4fde-ae69-5ca74d9dcab1	true	id.token.claim
e7b17874-53aa-4fde-ae69-5ca74d9dcab1	true	access.token.claim
e7b17874-53aa-4fde-ae69-5ca74d9dcab1	email_verified	claim.name
e7b17874-53aa-4fde-ae69-5ca74d9dcab1	boolean	jsonType.label
e2977dfa-f720-47c8-ba51-b816463d6b46	formatted	user.attribute.formatted
e2977dfa-f720-47c8-ba51-b816463d6b46	country	user.attribute.country
e2977dfa-f720-47c8-ba51-b816463d6b46	postal_code	user.attribute.postal_code
e2977dfa-f720-47c8-ba51-b816463d6b46	true	userinfo.token.claim
e2977dfa-f720-47c8-ba51-b816463d6b46	street	user.attribute.street
e2977dfa-f720-47c8-ba51-b816463d6b46	true	id.token.claim
e2977dfa-f720-47c8-ba51-b816463d6b46	region	user.attribute.region
e2977dfa-f720-47c8-ba51-b816463d6b46	true	access.token.claim
e2977dfa-f720-47c8-ba51-b816463d6b46	locality	user.attribute.locality
8438ba28-f864-4e68-b759-2547b19b035e	true	userinfo.token.claim
8438ba28-f864-4e68-b759-2547b19b035e	phoneNumber	user.attribute
8438ba28-f864-4e68-b759-2547b19b035e	true	id.token.claim
8438ba28-f864-4e68-b759-2547b19b035e	true	access.token.claim
8438ba28-f864-4e68-b759-2547b19b035e	phone_number	claim.name
8438ba28-f864-4e68-b759-2547b19b035e	String	jsonType.label
d94a6903-33ce-4608-ad6b-a786004d5596	true	userinfo.token.claim
d94a6903-33ce-4608-ad6b-a786004d5596	phoneNumberVerified	user.attribute
d94a6903-33ce-4608-ad6b-a786004d5596	true	id.token.claim
d94a6903-33ce-4608-ad6b-a786004d5596	true	access.token.claim
d94a6903-33ce-4608-ad6b-a786004d5596	phone_number_verified	claim.name
d94a6903-33ce-4608-ad6b-a786004d5596	boolean	jsonType.label
c3c38d76-62d9-4756-8f2d-fe0f9aab744a	true	multivalued
c3c38d76-62d9-4756-8f2d-fe0f9aab744a	foo	user.attribute
c3c38d76-62d9-4756-8f2d-fe0f9aab744a	true	access.token.claim
c3c38d76-62d9-4756-8f2d-fe0f9aab744a	realm_access.roles	claim.name
c3c38d76-62d9-4756-8f2d-fe0f9aab744a	String	jsonType.label
bc039a7a-199f-48af-aaca-7b2f603ad845	true	multivalued
bc039a7a-199f-48af-aaca-7b2f603ad845	foo	user.attribute
bc039a7a-199f-48af-aaca-7b2f603ad845	true	access.token.claim
bc039a7a-199f-48af-aaca-7b2f603ad845	resource_access.${client_id}.roles	claim.name
bc039a7a-199f-48af-aaca-7b2f603ad845	String	jsonType.label
0d67233c-7521-4180-8b54-e11d8a7b916b	true	userinfo.token.claim
0d67233c-7521-4180-8b54-e11d8a7b916b	username	user.attribute
0d67233c-7521-4180-8b54-e11d8a7b916b	true	id.token.claim
0d67233c-7521-4180-8b54-e11d8a7b916b	true	access.token.claim
0d67233c-7521-4180-8b54-e11d8a7b916b	upn	claim.name
0d67233c-7521-4180-8b54-e11d8a7b916b	String	jsonType.label
3d6d3e06-d496-4c0f-aeea-482bc997b82c	true	multivalued
3d6d3e06-d496-4c0f-aeea-482bc997b82c	foo	user.attribute
3d6d3e06-d496-4c0f-aeea-482bc997b82c	true	id.token.claim
3d6d3e06-d496-4c0f-aeea-482bc997b82c	true	access.token.claim
3d6d3e06-d496-4c0f-aeea-482bc997b82c	groups	claim.name
3d6d3e06-d496-4c0f-aeea-482bc997b82c	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me) FROM stdin;
master	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	6448f21f-8a1c-4e6b-9dfd-d39b4e9d7284	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	342e5625-3dde-4139-88c8-486056e92bc9	206563a1-19e0-4ec8-8452-4ca549aa5b40	6c59dea3-ad37-49e1-9c5c-5d091222e50f	733b84bd-aac5-42a8-b736-5e3e304b77e3	2e6b4e96-c95e-404a-b730-7e33da619eb9	2592000	f	900	t	f	56a75683-944d-4dcd-baac-761d990a132c	0	f	0	0
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_attribute (name, value, realm_id) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly		master
_browser_header.xContentTypeOptions	nosniff	master
_browser_header.xRobotsTag	none	master
_browser_header.xFrameOptions	SAMEORIGIN	master
_browser_header.contentSecurityPolicy	frame-src 'self'; frame-ancestors 'self'; object-src 'none';	master
_browser_header.xXSSProtection	1; mode=block	master
_browser_header.strictTransportSecurity	max-age=31536000; includeSubDomains	master
bruteForceProtected	false	master
permanentLockout	false	master
maxFailureWaitSeconds	900	master
minimumQuickLoginWaitSeconds	60	master
waitIncrementSeconds	60	master
quickLoginCheckMilliSeconds	1000	master
maxDeltaTimeSeconds	43200	master
failureFactor	30	master
displayName	Keycloak	master
displayNameHtml	<div class="kc-logo-text"><span>Keycloak</span></div>	master
offlineSessionMaxLifespanEnabled	false	master
offlineSessionMaxLifespan	5184000	master
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_default_roles; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_default_roles (realm_id, role_id) FROM stdin;
master	5ee7e070-cbc6-4765-880a-6c7bf9e4bc26
master	cb7dadb9-3777-4acb-b427-cfc9f05db45b
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
master	jboss-logging
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	master
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.redirect_uris (client_id, value) FROM stdin;
59dce76d-31c7-4e34-8ad9-b4482633e358	/realms/master/account/*
7c9b3b6d-b482-4861-9ba5-48c2a9dcd034	/realms/master/account/*
5373b568-d117-4882-8325-1dc15d4cbdaf	/admin/master/console/*
2c921c55-45b9-47e6-b5d4-1dc65f009a7a	https://express-openid-client/*
6bd6e1fa-3c19-4bde-a5d4-17e8b5f2c5af	https://angular-oauth2-oidc-client/*
7c6ca6bc-d284-4513-92cf-18b5e44ce99d	https://angular-auth-oidc-client/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
31b54016-f075-4331-b52a-292a0dd45844	VERIFY_EMAIL	Verify Email	master	t	f	VERIFY_EMAIL	50
e89990c0-e0ae-43d7-a1e4-922504082fe8	UPDATE_PROFILE	Update Profile	master	t	f	UPDATE_PROFILE	40
fad679c7-f759-481b-b26c-a1bcf30d0367	CONFIGURE_TOTP	Configure OTP	master	t	f	CONFIGURE_TOTP	10
b19591bf-c26d-44b1-8dba-c40df385e42b	UPDATE_PASSWORD	Update Password	master	t	f	UPDATE_PASSWORD	30
abbfa764-e799-4e40-9c48-7ed1c724911c	terms_and_conditions	Terms and Conditions	master	f	f	terms_and_conditions	20
95f86840-6cda-40e9-ad69-151962c79e9b	update_user_locale	Update User Locale	master	t	f	update_user_locale	1000
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
7c9b3b6d-b482-4861-9ba5-48c2a9dcd034	02d796c9-9416-4a2c-8c0a-390e38cd4f86
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_attribute (name, value, user_id, id) FROM stdin;
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
e31f6ba9-6c27-4725-995a-00a37a9e4a84	\N	51492371-c828-4c68-a3c5-0cb8c28782c0	f	t	\N	\N	\N	master	admin	1587483449132	\N	0
e8d50409-6fee-4589-a8e7-c985a6ac5cef	\N	a4fc6d29-b291-4b4d-9a54-cfd4cf847510	f	t	\N	\N	\N	master	user1	1587483565699	\N	0
b4095be3-9cb8-4eb6-9b5b-848192c038a5	\N	f6022207-cafb-4104-8f17-ff70806a05d7	f	t	\N	\N	\N	master	user2	1587483633071	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
7a1406bd-bd81-451d-a11b-827f5190e155	e31f6ba9-6c27-4725-995a-00a37a9e4a84
5ee7e070-cbc6-4765-880a-6c7bf9e4bc26	e31f6ba9-6c27-4725-995a-00a37a9e4a84
cb7dadb9-3777-4acb-b427-cfc9f05db45b	e31f6ba9-6c27-4725-995a-00a37a9e4a84
02d796c9-9416-4a2c-8c0a-390e38cd4f86	e31f6ba9-6c27-4725-995a-00a37a9e4a84
9d8d0dfe-b2b8-40d9-8056-6e69e0b67712	e31f6ba9-6c27-4725-995a-00a37a9e4a84
7a1406bd-bd81-451d-a11b-827f5190e155	e8d50409-6fee-4589-a8e7-c985a6ac5cef
5ee7e070-cbc6-4765-880a-6c7bf9e4bc26	e8d50409-6fee-4589-a8e7-c985a6ac5cef
cb7dadb9-3777-4acb-b427-cfc9f05db45b	e8d50409-6fee-4589-a8e7-c985a6ac5cef
02d796c9-9416-4a2c-8c0a-390e38cd4f86	e8d50409-6fee-4589-a8e7-c985a6ac5cef
7a1406bd-bd81-451d-a11b-827f5190e155	b4095be3-9cb8-4eb6-9b5b-848192c038a5
5ee7e070-cbc6-4765-880a-6c7bf9e4bc26	b4095be3-9cb8-4eb6-9b5b-848192c038a5
cb7dadb9-3777-4acb-b427-cfc9f05db45b	b4095be3-9cb8-4eb6-9b5b-848192c038a5
02d796c9-9416-4a2c-8c0a-390e38cd4f86	b4095be3-9cb8-4eb6-9b5b-848192c038a5
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.web_origins (client_id, value) FROM stdin;
5373b568-d117-4882-8325-1dc15d4cbdaf	+
2c921c55-45b9-47e6-b5d4-1dc65f009a7a	https://express-openid-client
6bd6e1fa-3c19-4bde-a5d4-17e8b5f2c5af	https://angular-oauth2-oidc-client
7c6ca6bc-d284-4513-92cf-18b5e44ce99d	https://angular-auth-oidc-client
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: client_default_roles constr_client_default_roles; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_default_roles
    ADD CONSTRAINT constr_client_default_roles PRIMARY KEY (client_id, role_id);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: realm_default_roles constraint_realm_default_roles; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_roles
    ADD CONSTRAINT constraint_realm_default_roles PRIMARY KEY (realm_id, role_id);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: databasechangeloglock pk_databasechangeloglock; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client_default_roles uk_8aelwnibji49avxsrtuf6xjow; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_default_roles
    ADD CONSTRAINT uk_8aelwnibji49avxsrtuf6xjow UNIQUE (role_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: realm_default_roles uk_h4wpd7w4hsoolni3h0sw7btje; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_roles
    ADD CONSTRAINT uk_h4wpd7w4hsoolni3h0sw7btje UNIQUE (role_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_def_roles_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_def_roles_client ON public.client_default_roles USING btree (client_id);


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_def_roles_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_def_roles_realm ON public.realm_default_roles USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_default_roles fk_8aelwnibji49avxsrtuf6xjow; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_default_roles
    ADD CONSTRAINT fk_8aelwnibji49avxsrtuf6xjow FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_client fk_c_cli_scope_client; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT fk_c_cli_scope_client FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_scope_client fk_c_cli_scope_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT fk_c_cli_scope_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_role; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_role FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_roles fk_evudb1ppw84oxfax2drs03icc; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_roles
    ADD CONSTRAINT fk_evudb1ppw84oxfax2drs03icc FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: keycloak_group fk_group_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT fk_group_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_role; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_role FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_default_roles fk_h4wpd7w4hsoolni3h0sw7btje; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_roles
    ADD CONSTRAINT fk_h4wpd7w4hsoolni3h0sw7btje FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: keycloak_role fk_kjho5le2c0ral09fl8cm9wfw9; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_kjho5le2c0ral09fl8cm9wfw9 FOREIGN KEY (client) REFERENCES public.client(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_default_roles fk_nuilts7klwqw2h8m2b5joytky; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_default_roles
    ADD CONSTRAINT fk_nuilts7klwqw2h8m2b5joytky FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_p3rh9grku11kqfrs4fltt7rnq; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_p3rh9grku11kqfrs4fltt7rnq FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: client fk_p56ctinxxb9gsk57fo49f9tac; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT fk_p56ctinxxb9gsk57fo49f9tac FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope fk_realm_cli_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT fk_realm_cli_scope FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: realm fk_traf444kk6qrkms7n56aiwq5y; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT fk_traf444kk6qrkms7n56aiwq5y FOREIGN KEY (master_admin_client) REFERENCES public.client(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

