--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: month(timestamp without time zone); Type: FUNCTION; Schema: public; Owner: axelor
--

CREATE FUNCTION month(timestamp without time zone) RETURNS integer
    LANGUAGE sql IMMUTABLE
    AS $_$ 
      SELECT EXTRACT(MONTH FROM $1)::INTEGER; 
$_$;


ALTER FUNCTION public.month(timestamp without time zone) OWNER TO axelor;

--
-- Name: month(timestamp with time zone); Type: FUNCTION; Schema: public; Owner: axelor
--

CREATE FUNCTION month(timestamp with time zone) RETURNS integer
    LANGUAGE sql STABLE
    AS $_$
      SELECT EXTRACT(MONTH FROM $1)::INTEGER;
$_$;


ALTER FUNCTION public.month(timestamp with time zone) OWNER TO axelor;

--
-- Name: month(date); Type: FUNCTION; Schema: public; Owner: axelor
--

CREATE FUNCTION month(date) RETURNS integer
    LANGUAGE sql IMMUTABLE
    AS $_$
      SELECT EXTRACT(MONTH FROM $1)::INTEGER;
$_$;


ALTER FUNCTION public.month(date) OWNER TO axelor;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: addressrcp; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE addressrcp (
    address_id integer NOT NULL,
    address_numstreet character varying(50),
    address_street character varying(50),
    address_zipcode character varying(50),
    address_city character varying(50),
    address_country character varying(50),
    address_compladdress character varying(50),
    address_recipient character varying(50)
);


ALTER TABLE public.addressrcp OWNER TO axelor;

--
-- Name: administrator; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE administrator (
    admin_id integer NOT NULL,
    admin_surname character varying(50) NOT NULL,
    admin_firstname character varying(50) NOT NULL,
    admin_phone character varying(50),
    admin_mobile character varying(50),
    admin_email character varying(50) NOT NULL,
    admin_function character varying(50) NOT NULL,
    admin_username character varying(50) NOT NULL,
    admin_password character varying(100) NOT NULL,
    admin_state character varying(50) NOT NULL,
    role_id integer NOT NULL,
    partner_id integer,
    inst_id integer
);


ALTER TABLE public.administrator OWNER TO axelor;

--
-- Name: algoconfig; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE algoconfig (
    machine_id integer NOT NULL,
    algoconfig_id integer NOT NULL,
    algoconfig_localdatetime timestamp without time zone,
    algoconfig_remotedatetime timestamp without time zone,
    algoconfig_localstatus character varying(50),
    algoconfig_remotestatus character varying(50)
);


ALTER TABLE public.algoconfig OWNER TO axelor;

--
-- Name: algoparam; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE algoparam (
    algoparam_id integer NOT NULL,
    algoconfig_id integer NOT NULL,
    algoparam_name character varying(100),
    algoparam_type character varying(50),
    algoparam_value character varying(50),
    algoparam_unit character varying(50),
    algoparam_maxvalue character varying(50),
    algoparam_minvalue character varying(50)
);


ALTER TABLE public.algoparam OWNER TO axelor;

--
-- Name: armoire; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE armoire (
    armoire_id integer NOT NULL,
    building_id integer NOT NULL,
    armoire_location character varying(50) NOT NULL,
    armoire_number integer NOT NULL,
    name character varying(1024) DEFAULT ''::character varying NOT NULL,
    floor character varying(50) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.armoire OWNER TO axelor;

--
-- Name: bridge; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE bridge (
    bridge_id integer NOT NULL,
    bridgemodel_id integer NOT NULL,
    gateway_id integer NOT NULL,
    bridge_rfaddress integer NOT NULL,
    coffret_id integer,
    bridge_an integer NOT NULL,
    active boolean DEFAULT false NOT NULL
);


ALTER TABLE public.bridge OWNER TO axelor;

--
-- Name: bridgemark; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE bridgemark (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE public.bridgemark OWNER TO postgres;

--
-- Name: bridgemodel; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE bridgemodel (
    bridgemodel_id integer NOT NULL,
    bridgemodel_mark character varying(50) NOT NULL,
    bridgemodel_model character varying(50) NOT NULL,
    bridgemark_id integer
);


ALTER TABLE public.bridgemodel OWNER TO axelor;

--
-- Name: building; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE building (
    building_id integer NOT NULL,
    site_id integer NOT NULL,
    name character varying(1024) DEFAULT ''::character varying NOT NULL,
    description character varying(1024) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.building OWNER TO axelor;

--
-- Name: clientrcp; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE clientrcp (
    client_id integer NOT NULL,
    client_iduser integer,
    client_num character varying(50),
    measurpoint_id integer,
    address_id integer
);


ALTER TABLE public.clientrcp OWNER TO axelor;

--
-- Name: clientrcp_client_id_seq; Type: SEQUENCE; Schema: public; Owner: axelor
--

CREATE SEQUENCE clientrcp_client_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.clientrcp_client_id_seq OWNER TO axelor;

--
-- Name: clientrcp_client_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: axelor
--

ALTER SEQUENCE clientrcp_client_id_seq OWNED BY clientrcp.client_id;


--
-- Name: coffret; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE coffret (
    coffret_id integer NOT NULL,
    powersupply_id integer,
    coffretmodel_id integer NOT NULL,
    armoire_id integer NOT NULL,
    name character varying(1024) DEFAULT ''::character varying NOT NULL,
    location character varying(1024) DEFAULT ''::character varying NOT NULL,
    grappe_id integer
);


ALTER TABLE public.coffret OWNER TO axelor;

--
-- Name: coffretmark; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE coffretmark (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE public.coffretmark OWNER TO postgres;

--
-- Name: coffretmodel; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE coffretmodel (
    coffretmodel_id integer NOT NULL,
    coffretmodel_mark character varying(50) NOT NULL,
    coffretmodel_model character varying(50) NOT NULL,
    coffretmark_id integer
);


ALTER TABLE public.coffretmodel OWNER TO axelor;

--
-- Name: comment; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE comment (
    comm_text character varying(100) NOT NULL,
    inst_id integer,
    site_id integer,
    comm_id integer NOT NULL,
    comm_date timestamp without time zone
);


ALTER TABLE public.comment OWNER TO axelor;

--
-- Name: configparam; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE configparam (
    configparam_id integer NOT NULL,
    configparam_gr_bmp_io integer,
    configparam_gr_num integer,
    configparam_gw_num integer,
    terminal_id integer NOT NULL,
    configparam_factor_k integer,
    configparam_fu integer,
    terminal_identifier character varying(50) NOT NULL,
    configparam_state character varying(10)
);


ALTER TABLE public.configparam OWNER TO axelor;

--
-- Name: ctmark; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ctmark (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE public.ctmark OWNER TO postgres;

--
-- Name: ctmodel; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE ctmodel (
    ctmodel_mark character varying(50) NOT NULL,
    ctmodel_model character varying(50) NOT NULL,
    ctmodel_id integer NOT NULL,
    ctmodel_maximumcurrent real NOT NULL,
    ctmodel_external boolean DEFAULT false NOT NULL,
    ctmodel_ratio integer DEFAULT 1 NOT NULL,
    mark_id integer
);


ALTER TABLE public.ctmodel OWNER TO axelor;

--
-- Name: customer; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE customer (
    customer_companyname character varying(50) NOT NULL,
    customer_firstname character varying(50) NOT NULL,
    customer_surname character varying(50) NOT NULL,
    customer_occuption character varying(50) NOT NULL,
    customer_address character varying(50) NOT NULL,
    customer_city character varying(50) NOT NULL,
    customer_zip character varying(50) NOT NULL,
    customer_country character varying(50) NOT NULL,
    customer_phone character varying(50),
    customer_mobile character varying(50),
    customer_email character varying(50) NOT NULL,
    customer_id integer NOT NULL,
    customer_login character varying(50),
    customer_password character varying(100),
    customer_state character varying(10),
    partner_id integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.customer OWNER TO axelor;

--
-- Name: customerorder; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE customerorder (
    order_description character varying(50) NOT NULL,
    order_date timestamp without time zone NOT NULL,
    order_id integer NOT NULL,
    order_state character varying(50) NOT NULL,
    site_id integer NOT NULL
);


ALTER TABLE public.customerorder OWNER TO axelor;

--
-- Name: device2measuregroup; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE device2measuregroup (
    id integer NOT NULL,
    group_id integer NOT NULL,
    terminal_id integer,
    submeter_id integer,
    operation character varying(1024) NOT NULL,
    sensor_id integer
);


ALTER TABLE public.device2measuregroup OWNER TO postgres;

--
-- Name: mesureparam; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE mesureparam (
    mesure_id integer NOT NULL,
    mesure_terminal_identifier integer NOT NULL,
    mesure_datetime timestamp without time zone NOT NULL,
    mesure_iph1 real,
    mesure_iph2 real,
    mesure_iph3 real,
    mesure_ip real,
    mesure_ipp real,
    mesure_uph1 real,
    mesure_uph2 real,
    mesure_uph3 real,
    mesure_up real,
    mesure_upp real,
    mesure_f real,
    mesure_pa real,
    mesure_pav real,
    mesure_pr real,
    mesure_ec real,
    mesure_eg real,
    mesure_erc real,
    mesure_erg real,
    mesure_phirad real,
    mesure_cosphi real,
    mesure_phideg real,
    mesure_decisiondatetime timestamp without time zone,
    terminal_id integer,
    mesure_decisionstate real,
    mesure_eac real,
    mesure_eag real,
    mesure_e1c real,
    mesure_e1g real
);


ALTER TABLE public.mesureparam OWNER TO axelor;

--
-- Name: elti; Type: VIEW; Schema: public; Owner: axelor
--

CREATE VIEW elti AS
    SELECT mesureparam.mesure_id, mesureparam.mesure_terminal_identifier, mesureparam.mesure_datetime, mesureparam.mesure_iph1, mesureparam.mesure_iph2, mesureparam.mesure_iph3, mesureparam.mesure_ip, mesureparam.mesure_ipp, mesureparam.mesure_uph1, mesureparam.mesure_uph2, mesureparam.mesure_uph3, mesureparam.mesure_up, mesureparam.mesure_upp, mesureparam.mesure_f, mesureparam.mesure_pa, mesureparam.mesure_pav, mesureparam.mesure_pr, mesureparam.mesure_ec, mesureparam.mesure_eg, mesureparam.mesure_erc, mesureparam.mesure_erg, mesureparam.mesure_phirad, mesureparam.mesure_cosphi, mesureparam.mesure_phideg, mesureparam.mesure_decisiondatetime, mesureparam.terminal_id, mesureparam.mesure_decisionstate, mesureparam.mesure_eac, mesureparam.mesure_eag, mesureparam.mesure_e1c, mesureparam.mesure_e1g FROM mesureparam WHERE ((mesureparam.mesure_datetime > '2017-10-28 00:00:00'::timestamp without time zone) AND (mesureparam.mesure_terminal_identifier = 65579));


ALTER TABLE public.elti OWNER TO axelor;

--
-- Name: fabricationorder; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE fabricationorder (
    fabricationorder_id integer NOT NULL,
    fabricationorder_of character varying(100),
    fabricationorder_datetime timestamp without time zone,
    fabricationorder_machine character varying(100)
);


ALTER TABLE public.fabricationorder OWNER TO postgres;

--
-- Name: fabricationorder_fabricationorder_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE fabricationorder_fabricationorder_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fabricationorder_fabricationorder_id_seq OWNER TO postgres;

--
-- Name: fabricationorder_fabricationorder_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE fabricationorder_fabricationorder_id_seq OWNED BY fabricationorder.fabricationorder_id;


--
-- Name: fabricationordervalue; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE fabricationordervalue (
    fabricationorder_id integer NOT NULL,
    sensor_id integer NOT NULL,
    fabricationordervalue_value double precision
);


ALTER TABLE public.fabricationordervalue OWNER TO postgres;

--
-- Name: fabricationordervalue_fabricationorder_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE fabricationordervalue_fabricationorder_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fabricationordervalue_fabricationorder_id_seq OWNER TO postgres;

--
-- Name: fabricationordervalue_fabricationorder_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE fabricationordervalue_fabricationorder_id_seq OWNED BY fabricationordervalue.fabricationorder_id;


--
-- Name: facturationref; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE facturationref (
    facturationref_reference double precision NOT NULL,
    facturationref_objective double precision NOT NULL,
    facturationref_date date NOT NULL,
    site_id integer NOT NULL,
    timeslot_id integer NOT NULL
);


ALTER TABLE public.facturationref OWNER TO axelor;

--
-- Name: facturedetail; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE facturedetail (
    facturedetail_id integer NOT NULL,
    facture_num character varying(50),
    detailtruct_id integer,
    facturedetail_quantity double precision,
    facturedetail_price double precision,
    facturedetail_amount double precision,
    facturedetail_tva double precision,
    facturedetail_percentage double precision,
    facturedetail_unit character varying(50)
);


ALTER TABLE public.facturedetail OWNER TO axelor;

--
-- Name: facturedetail_facturedetail_id_seq; Type: SEQUENCE; Schema: public; Owner: axelor
--

CREATE SEQUENCE facturedetail_facturedetail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.facturedetail_facturedetail_id_seq OWNER TO axelor;

--
-- Name: facturedetail_facturedetail_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: axelor
--

ALTER SEQUENCE facturedetail_facturedetail_id_seq OWNED BY facturedetail.facturedetail_id;


--
-- Name: facturedetailstruct; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE facturedetailstruct (
    detailtruct_id integer NOT NULL,
    detailtruct_numtable integer,
    detailtruct_column integer,
    detailtruct_name character varying(50),
    timeslot_id integer
);


ALTER TABLE public.facturedetailstruct OWNER TO axelor;

--
-- Name: facturercp; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE facturercp (
    facture_num character varying(50) NOT NULL,
    client_id integer,
    facture_amountwithtva character varying(50),
    facture_amountwithouttva character varying(50),
    measurpoint_id integer,
    facture_daystart integer,
    facture_dayend integer,
    facture_daylimite integer,
    facture_monthlimit integer,
    facture_yearlimit integer,
    facture_daycreation integer,
    facture_monthcreation integer,
    facture_month integer,
    facture_year integer,
    facture_yearcreation integer
);


ALTER TABLE public.facturercp OWNER TO axelor;

--
-- Name: flux_energetique; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE flux_energetique (
    flux_id integer NOT NULL,
    date_insertion timestamp without time zone NOT NULL,
    month integer,
    year integer,
    hc double precision,
    hp double precision,
    last_vcp_month double precision,
    first_vcp_month double precision,
    total_energy double precision,
    injected_pv double precision,
    pv_total double precision,
    pv_consumed_rcp double precision,
    pic_puissance double precision,
    hp_tarif double precision,
    hc_tarif double precision,
    injectedpvtarif double precision,
    pvconsumedbyrcptarif double precision
);


ALTER TABLE public.flux_energetique OWNER TO axelor;

--
-- Name: gateway; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE gateway (
    gateway_identifier character varying(50) NOT NULL,
    gateway_state character varying(50) NOT NULL,
    gateway_id integer NOT NULL,
    gwmodel_id integer NOT NULL,
    site_id integer NOT NULL,
    gateway_version character varying(10) NOT NULL,
    gateway_password character varying(50),
    building_id integer,
    coffret_id integer,
    gateway_updateparam boolean DEFAULT false NOT NULL,
    gateway_reverseengineering boolean DEFAULT false NOT NULL
);


ALTER TABLE public.gateway OWNER TO axelor;

--
-- Name: gatewaymark; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE gatewaymark (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE public.gatewaymark OWNER TO postgres;

--
-- Name: gatewaymodel; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE gatewaymodel (
    gwmodel_mark character varying(50) NOT NULL,
    gwmodel_communicationtype character varying(20) NOT NULL,
    gwmodel_id integer NOT NULL,
    gwmodel_model character varying(50) NOT NULL,
    mark_id integer
);


ALTER TABLE public.gatewaymodel OWNER TO axelor;

--
-- Name: grappe; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE grappe (
    id integer NOT NULL,
    name character varying,
    site_id integer
);


ALTER TABLE public.grappe OWNER TO postgres;

--
-- Name: ig; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE ig (
    ig_id integer NOT NULL,
    igmodel_id integer NOT NULL,
    coffret_id integer,
    active boolean DEFAULT false NOT NULL
);


ALTER TABLE public.ig OWNER TO axelor;

--
-- Name: igmark; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE igmark (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE public.igmark OWNER TO postgres;

--
-- Name: igmodel; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE igmodel (
    igmodel_id integer NOT NULL,
    igmodel_mark character varying(50) NOT NULL,
    igmodel_model character varying(50) NOT NULL,
    igmark_id integer
);


ALTER TABLE public.igmodel OWNER TO axelor;

--
-- Name: installer; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE installer (
    inst_company_name character varying(50),
    inst_company_adresse character varying(50),
    inst_company_zip character varying(50),
    inst_company_city character varying(50),
    inst_company_country character varying(50),
    inst_surname character varying(50),
    inst_firstname character varying(50),
    inst_function character varying(50),
    inst_phone character varying(50),
    inst_fax character varying(50),
    inst_mobile character varying(50),
    inst_email character varying(50),
    inst_id integer NOT NULL
);


ALTER TABLE public.installer OWNER TO axelor;

--
-- Name: ismodbus; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE ismodbus (
    ismodbus_id integer NOT NULL,
    gateway_id integer NOT NULL,
    ig_id integer,
    bridge_id integer,
    ismodbusmodel_id integer NOT NULL,
    ismodbus_address integer NOT NULL
);


ALTER TABLE public.ismodbus OWNER TO axelor;

--
-- Name: ismodbusmodel; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE ismodbusmodel (
    ismodbusmodel_id integer NOT NULL,
    ismodbusmodel_mark character varying(50) NOT NULL,
    ismodbusmodel_model character varying(50) NOT NULL,
    ismodbusmodel_maxsensor integer NOT NULL,
    ismodbusmodel_type character varying(50) NOT NULL
);


ALTER TABLE public.ismodbusmodel OWNER TO axelor;

--
-- Name: license; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE license (
    id bigint NOT NULL,
    customer_id bigint NOT NULL,
    active boolean NOT NULL,
    license_number character varying(1024) NOT NULL,
    start_date timestamp without time zone,
    end_date timestamp without time zone
);


ALTER TABLE public.license OWNER TO postgres;

--
-- Name: machine; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE machine (
    machine_id integer NOT NULL,
    site_id integer NOT NULL,
    machinetype_id integer NOT NULL,
    machine_nominalcurrent real NOT NULL,
    machine_number integer NOT NULL,
    machine_state character varying(10) NOT NULL,
    machine_servicetype character varying(20) NOT NULL,
    machine_phase character varying(50) NOT NULL,
    machine_powercuttype character varying(20) NOT NULL,
    machine_version character varying(10) NOT NULL,
    electricalpanel_id integer NOT NULL,
    eco_mode boolean,
    timer_mode boolean,
    analyse_edco boolean DEFAULT true,
    machine_ofid character varying(100),
    machine_name character varying(100)
);


ALTER TABLE public.machine OWNER TO axelor;

--
-- Name: machinealgoparam; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE machinealgoparam (
    machinealgoparam_id integer NOT NULL,
    machinealgoparam_parent_id integer,
    machinealgoparam_administrator_id integer,
    machinealgoparam_machine_id integer,
    machinealgoparam_date date,
    machinealgoparam_status character varying(50),
    machinealgoparam_statusgw character varying(50)
);


ALTER TABLE public.machinealgoparam OWNER TO postgres;

--
-- Name: machinealgoparam_machinealgoparam_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE machinealgoparam_machinealgoparam_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.machinealgoparam_machinealgoparam_id_seq OWNER TO postgres;

--
-- Name: machinealgoparam_machinealgoparam_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE machinealgoparam_machinealgoparam_id_seq OWNED BY machinealgoparam.machinealgoparam_id;


--
-- Name: machinealgoparamlist; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE machinealgoparamlist (
    machinealgoparamlist_id integer NOT NULL,
    machinealgoparamlist_name character varying,
    machinealgoparamlist_type character varying,
    machinealgoparamlist_groupe integer,
    machinealgoparamlist_min integer,
    machinealgoparamlist_max integer,
    machinealgoparamlist_infoiconnumber integer
);


ALTER TABLE public.machinealgoparamlist OWNER TO postgres;

--
-- Name: machinealgoparamlist_machinealgoparamlist_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE machinealgoparamlist_machinealgoparamlist_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.machinealgoparamlist_machinealgoparamlist_id_seq OWNER TO postgres;

--
-- Name: machinealgoparamlist_machinealgoparamlist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE machinealgoparamlist_machinealgoparamlist_id_seq OWNED BY machinealgoparamlist.machinealgoparamlist_id;


--
-- Name: machinealgoparamvalue; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE machinealgoparamvalue (
    machinealgoparamvalue_machinealgoparam_id integer NOT NULL,
    machinealgoparamvalue_machinealgoparamlist_id integer NOT NULL,
    machinealgoparamvalue_valeur character varying(50)
);


ALTER TABLE public.machinealgoparamvalue OWNER TO postgres;

--
-- Name: machinetype; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE machinetype (
    machinetype_name character varying(50) NOT NULL,
    machinetype_id integer NOT NULL
);


ALTER TABLE public.machinetype OWNER TO axelor;

--
-- Name: maintenance; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE maintenance (
    maintenance_id integer NOT NULL,
    site_id integer NOT NULL,
    maintenance_type character varying(50) NOT NULL,
    maintenance_description character varying(50) NOT NULL,
    date_install date,
    date_visit date
);


ALTER TABLE public.maintenance OWNER TO axelor;

--
-- Name: measuregroup; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE measuregroup (
    id integer NOT NULL,
    site_id integer,
    name character varying(1024) NOT NULL,
    group_type integer DEFAULT 0 NOT NULL,
    description character varying(1024)
);


ALTER TABLE public.measuregroup OWNER TO postgres;

--
-- Name: measurpointrcp; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE measurpointrcp (
    measurpoint_id integer NOT NULL,
    measurpoint_name character varying(50),
    address_id integer,
    tarif_id integer
);


ALTER TABLE public.measurpointrcp OWNER TO axelor;

--
-- Name: measurpointrcp_measurpoint_id_seq; Type: SEQUENCE; Schema: public; Owner: axelor
--

CREATE SEQUENCE measurpointrcp_measurpoint_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.measurpointrcp_measurpoint_id_seq OWNER TO axelor;

--
-- Name: measurpointrcp_measurpoint_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: axelor
--

ALTER SEQUENCE measurpointrcp_measurpoint_id_seq OWNED BY measurpointrcp.measurpoint_id;


--
-- Name: menugroup; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE menugroup (
    id bigint NOT NULL,
    name character varying(1024) NOT NULL,
    shortcut_name character varying(1024) NOT NULL,
    active boolean NOT NULL,
    action_url character varying NOT NULL,
    do_action character varying,
    "position" bigint,
    visible boolean NOT NULL,
    parent_id bigint
);


ALTER TABLE public.menugroup OWNER TO postgres;

--
-- Name: menugroup2customer; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE menugroup2customer (
    customer_id bigint NOT NULL,
    menu_id bigint NOT NULL,
    license_id bigint NOT NULL
);


ALTER TABLE public.menugroup2customer OWNER TO postgres;

--
-- Name: mesuresrcp; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE mesuresrcp (
    mesure_id integer NOT NULL,
    measurpoint_id integer,
    mesures_date timestamp without time zone NOT NULL,
    vcc double precision NOT NULL,
    vcp double precision NOT NULL,
    vcr double precision NOT NULL,
    production double precision DEFAULT 0,
    consumption double precision DEFAULT 0,
    reactive double precision DEFAULT 0,
    counted boolean DEFAULT false,
    storedonserve boolean DEFAULT false,
    interpolated boolean DEFAULT false
);


ALTER TABLE public.mesuresrcp OWNER TO axelor;

--
-- Name: mesuresrcp_mesure_id_seq; Type: SEQUENCE; Schema: public; Owner: axelor
--

CREATE SEQUENCE mesuresrcp_mesure_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mesuresrcp_mesure_id_seq OWNER TO axelor;

--
-- Name: mesuresrcp_mesure_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: axelor
--

ALTER SEQUENCE mesuresrcp_mesure_id_seq OWNED BY mesuresrcp.mesure_id;


--
-- Name: orderitem; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE orderitem (
    item_state character varying(50) NOT NULL,
    item_id integer NOT NULL,
    order_id integer NOT NULL,
    proudct_id integer NOT NULL,
    model_id integer NOT NULL
);


ALTER TABLE public.orderitem OWNER TO axelor;

--
-- Name: page; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE page (
    page_name character varying(50) NOT NULL,
    page_id integer NOT NULL,
    cat_id integer NOT NULL
);


ALTER TABLE public.page OWNER TO axelor;

--
-- Name: pagecategory; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE pagecategory (
    cat_groupname character varying(50) NOT NULL,
    cat_actionname character varying(50) NOT NULL,
    cat_description character varying(60) NOT NULL,
    cat_id integer NOT NULL
);


ALTER TABLE public.pagecategory OWNER TO axelor;

--
-- Name: partner; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE partner (
    partner_id bigint NOT NULL,
    partner_name character varying(50),
    partner_username character varying(50),
    partner_firstname character varying(50),
    partner_occuption character varying(50),
    partner_address character varying(50),
    partner_city character varying(50),
    partner_country character varying(50),
    partner_phone character varying(50),
    partner_mobile character varying(50),
    partner_email character varying(50),
    partner_state character varying(50),
    partner_zip character varying(50)
);


ALTER TABLE public.partner OWNER TO axelor;

--
-- Name: partnerinstaller; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE partnerinstaller (
    partner_id integer NOT NULL,
    inst_id integer NOT NULL
);


ALTER TABLE public.partnerinstaller OWNER TO axelor;

--
-- Name: permission; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE permission (
    permission_pagename character varying(50) NOT NULL,
    permission_id integer NOT NULL,
    roles_id integer NOT NULL,
    page_id integer NOT NULL
);


ALTER TABLE public.permission OWNER TO axelor;

--
-- Name: powersupply; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE powersupply (
    powersupply_id integer NOT NULL,
    powersupplymodel_id integer NOT NULL
);


ALTER TABLE public.powersupply OWNER TO axelor;

--
-- Name: powersupplymodel; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE powersupplymodel (
    powersupplymodel_id integer NOT NULL,
    powersupplymodel_mark character varying(50) NOT NULL,
    powersupplymodel_model character varying(50) NOT NULL
);


ALTER TABLE public.powersupplymodel OWNER TO axelor;

--
-- Name: product; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE product (
    product_name character varying(50) NOT NULL,
    product_mark character varying(50) NOT NULL,
    product_model character varying(50) NOT NULL,
    product_description character varying(50),
    product_quantity integer NOT NULL,
    product_picture character varying(50),
    product_id integer NOT NULL,
    partner_id integer,
    product_resquantity integer
);


ALTER TABLE public.product OWNER TO axelor;

--
-- Name: rely; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE rely (
    rely_mark character varying(50),
    rely_model character varying(50),
    rely_type character varying(50),
    rely_nominalcurrent integer,
    rely_id integer NOT NULL
);


ALTER TABLE public.rely OWNER TO axelor;

--
-- Name: reportenergy; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE reportenergy (
    terminal_id integer NOT NULL,
    energy_timestamp timestamp without time zone NOT NULL,
    energy_hc double precision,
    energy_hp double precision,
    is_submeter boolean,
    energy_type integer
);


ALTER TABLE public.reportenergy OWNER TO axelor;

--
-- Name: reportload; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE reportload (
    terminal_id integer NOT NULL,
    load_timestamp timestamp without time zone NOT NULL,
    load_1 double precision,
    load_2 double precision,
    load_3 double precision,
    load_4 double precision,
    load_5 double precision,
    load_6 double precision,
    load_7 double precision,
    load_8 double precision,
    load_9 double precision,
    load_10 double precision,
    load_11 double precision,
    load_12 double precision,
    load_13 double precision,
    load_14 double precision,
    load_15 double precision,
    load_16 double precision,
    load_17 double precision,
    load_18 double precision,
    load_19 double precision,
    load_20 double precision,
    load_21 double precision,
    load_22 double precision,
    load_23 double precision,
    load_24 double precision,
    load_25 double precision,
    load_26 double precision,
    load_27 double precision,
    load_28 double precision,
    load_29 double precision,
    load_30 double precision,
    load_31 double precision,
    load_32 double precision,
    load_33 double precision,
    load_34 double precision,
    load_35 double precision,
    load_36 double precision,
    load_37 double precision,
    load_38 double precision,
    load_39 double precision,
    load_40 double precision,
    load_41 double precision,
    load_42 double precision,
    load_43 double precision,
    load_44 double precision,
    load_45 double precision,
    load_46 double precision,
    load_47 double precision,
    load_48 double precision,
    load_49 double precision,
    load_50 double precision,
    load_51 double precision,
    load_52 double precision,
    load_53 double precision,
    load_54 double precision,
    load_55 double precision,
    load_56 double precision,
    load_57 double precision,
    load_58 double precision,
    load_59 double precision,
    load_60 double precision,
    load_61 double precision,
    load_62 double precision,
    load_63 double precision,
    load_64 double precision,
    load_65 double precision,
    load_66 double precision,
    load_67 double precision,
    load_68 double precision,
    load_69 double precision,
    load_70 double precision,
    load_71 double precision,
    load_72 double precision,
    load_73 double precision,
    load_74 double precision,
    load_75 double precision,
    load_76 double precision,
    load_77 double precision,
    load_78 double precision,
    load_79 double precision,
    load_80 double precision,
    load_81 double precision,
    load_82 double precision,
    load_83 double precision,
    load_84 double precision,
    load_85 double precision,
    load_86 double precision,
    load_87 double precision,
    load_88 double precision,
    load_89 double precision,
    load_90 double precision,
    load_91 double precision,
    load_92 double precision,
    load_93 double precision,
    load_94 double precision,
    load_95 double precision,
    load_96 double precision,
    load_97 double precision,
    load_98 double precision,
    load_99 double precision,
    load_100 double precision,
    load_101 double precision,
    load_102 double precision,
    load_103 double precision,
    load_104 double precision,
    load_105 double precision,
    load_106 double precision,
    load_107 double precision,
    load_108 double precision,
    load_109 double precision,
    load_110 double precision,
    load_111 double precision,
    load_112 double precision,
    load_113 double precision,
    load_114 double precision,
    load_115 double precision,
    load_116 double precision,
    load_117 double precision,
    load_118 double precision,
    load_119 double precision,
    load_120 double precision,
    load_121 double precision,
    load_122 double precision,
    load_123 double precision,
    load_124 double precision,
    load_125 double precision,
    load_126 double precision,
    load_127 double precision,
    load_128 double precision,
    load_129 double precision,
    load_130 double precision,
    load_131 double precision,
    load_132 double precision,
    load_133 double precision,
    load_134 double precision,
    load_135 double precision,
    load_136 double precision,
    load_137 double precision,
    load_138 double precision,
    load_139 double precision,
    load_140 double precision,
    load_141 double precision,
    load_142 double precision,
    load_143 double precision,
    load_144 double precision,
    load_145 double precision,
    load_146 double precision,
    load_147 double precision,
    load_148 double precision,
    load_149 double precision,
    load_150 double precision,
    is_submeter boolean
);


ALTER TABLE public.reportload OWNER TO axelor;

--
-- Name: reportpower; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE reportpower (
    terminal_id integer NOT NULL,
    power_timestamp timestamp without time zone NOT NULL,
    power_value double precision,
    is_submeter boolean
);


ALTER TABLE public.reportpower OWNER TO axelor;

--
-- Name: reversemesureparam; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE reversemesureparam (
    terminal_id integer NOT NULL,
    mesure_datetime timestamp without time zone NOT NULL,
    mesure_p_deltae double precision,
    mesure_e_deltae double precision
);


ALTER TABLE public.reversemesureparam OWNER TO postgres;

--
-- Name: reverseparam; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE reverseparam (
    terminal_id integer NOT NULL,
    rp_profile_type integer NOT NULL,
    rp_param1 double precision DEFAULT 0 NOT NULL,
    rp_param2 double precision DEFAULT 0 NOT NULL,
    rp_param3 double precision DEFAULT 0 NOT NULL,
    rp_param4 double precision DEFAULT 0 NOT NULL,
    rp_param5 double precision DEFAULT 0 NOT NULL,
    rp_param6 double precision DEFAULT 0 NOT NULL,
    rp_param7 double precision DEFAULT 0 NOT NULL,
    rp_param8 double precision DEFAULT 0 NOT NULL,
    rp_param9 double precision DEFAULT 0 NOT NULL,
    rp_param10 double precision DEFAULT 0 NOT NULL
);


ALTER TABLE public.reverseparam OWNER TO postgres;

--
-- Name: roles; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE roles (
    roles_name character varying(50) NOT NULL,
    role_id integer NOT NULL
);


ALTER TABLE public.roles OWNER TO axelor;

--
-- Name: schema_version; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE schema_version (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


ALTER TABLE public.schema_version OWNER TO postgres;

--
-- Name: scmesureparam; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE scmesureparam (
    mesure_id integer,
    mesure_submeter_identifier integer NOT NULL,
    mesure_datetime timestamp without time zone NOT NULL,
    mesure_iph1 real,
    mesure_iph2 real,
    mesure_iph3 real,
    mesure_ip real,
    mesure_ipp real,
    mesure_uph1 real,
    mesure_uph2 real,
    mesure_uph3 real,
    mesure_up real,
    mesure_upp real,
    mesure_f real,
    mesure_pa real,
    mesure_pav real,
    mesure_pr real,
    mesure_ec real,
    mesure_eg real,
    mesure_erc real,
    mesure_erg real,
    mesure_phirad real,
    mesure_cosphi real,
    mesure_phideg real,
    mesure_decisiondatetime timestamp without time zone,
    submeter_id integer,
    mesure_decisionstate real,
    mesure_eac real,
    mesure_eag real,
    mesure_e1c real,
    mesure_e1g real,
    mesure_pqh real
);


ALTER TABLE public.scmesureparam OWNER TO axelor;

--
-- Name: season; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE season (
    season_id integer NOT NULL,
    season_name character varying(50) NOT NULL,
    season_start_month integer NOT NULL,
    season_end_month integer NOT NULL,
    tarif_id integer NOT NULL,
    season_status character varying(50) NOT NULL
);


ALTER TABLE public.season OWNER TO axelor;

--
-- Name: axelorrole; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE axelorrole (
    id bigint NOT NULL,
    name character varying(1024) NOT NULL,
    profile character varying(1024) NOT NULL,
    active boolean NOT NULL,
    site_id integer,
    customer_id integer,
    description character varying(1024)
);


ALTER TABLE public.axelorrole OWNER TO postgres;

--
-- Name: axelorrole2menugroup; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE axelorrole2menugroup (
    role_id bigint NOT NULL,
    menu_id bigint NOT NULL,
    control_mode character varying NOT NULL
);


ALTER TABLE public.axelorrole2menugroup OWNER TO postgres;

--
-- Name: axeloruser; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE axeloruser (
    id bigint NOT NULL,
    name character varying(1024) NOT NULL,
    login character varying(1024) NOT NULL,
    password character varying(1024) NOT NULL,
    language character varying(1024) NOT NULL,
    active boolean NOT NULL,
    email character varying(1024) NOT NULL,
    must_change_password boolean,
    has_changed_password boolean,
    customer_id integer
);


ALTER TABLE public.axeloruser OWNER TO postgres;

--
-- Name: sensor; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE sensor (
    sensor_id integer NOT NULL,
    ismodbus_id integer NOT NULL,
    sensormodel_id integer NOT NULL,
    sensor_register integer NOT NULL,
    sensor_name character varying(20)
);


ALTER TABLE public.sensor OWNER TO axelor;

--
-- Name: sensor2measuregroup; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sensor2measuregroup (
    id integer NOT NULL,
    group_id integer NOT NULL,
    description character varying(1024) NOT NULL,
    sensor_id integer,
    operation character varying(1024) NOT NULL,
    periode character varying(24) NOT NULL,
    label character varying(1024) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.sensor2measuregroup OWNER TO postgres;

--
-- Name: sensormeasurement; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE sensormeasurement (
    sensormeasurement_datetime timestamp without time zone NOT NULL,
    sensormeasurement_value real NOT NULL,
    sensor_id integer NOT NULL
);


ALTER TABLE public.sensormeasurement OWNER TO axelor;

--
-- Name: sensormodel; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE sensormodel (
    sensormodel_id integer NOT NULL,
    sensormodel_mark character varying(50) NOT NULL,
    sensormodel_model character varying(50) NOT NULL,
    sensormodel_type character varying(50) NOT NULL,
    sensormodel_unit character varying(50) NOT NULL,
    sensormodel_minvalue real NOT NULL,
    sensormodel_maxvalue real NOT NULL
);


ALTER TABLE public.sensormodel OWNER TO axelor;

--
-- Name: sensorterminal; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE sensorterminal (
    terminal_id integer NOT NULL,
    sensor_id integer NOT NULL
);


ALTER TABLE public.sensorterminal OWNER TO axelor;

--
-- Name: site; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE site (
    site_name character varying(50) NOT NULL,
    site_address character varying(50) NOT NULL,
    site_city character varying(50) NOT NULL,
    site_zip character varying(50) NOT NULL,
    site_country character varying(50) NOT NULL,
    site_surname character varying(50) NOT NULL,
    site_firstname character varying(50) NOT NULL,
    site_occuption character varying(50) NOT NULL,
    site_email character varying(50) NOT NULL,
    site_phone character varying(50),
    site_mobile character varying(50),
    site_id integer NOT NULL,
    customer_id integer NOT NULL,
    site_nominalcurrent real NOT NULL,
    inst_id integer,
    site_timezone character varying(50) NOT NULL,
    site_state character varying(50),
    date_visit date,
    date_install date,
    order_state character varying(50),
    site_maxco2 integer DEFAULT 1000 NOT NULL,
    site_type character varying(20) DEFAULT 'EDCO'::character varying NOT NULL
);


ALTER TABLE public.site OWNER TO axelor;

--
-- Name: sitetarification; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE sitetarification (
    site_id integer NOT NULL,
    tarif_id integer NOT NULL
);


ALTER TABLE public.sitetarification OWNER TO axelor;

--
-- Name: sitetimeslot; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE sitetimeslot (
    site_id integer NOT NULL,
    timeslot_id integer NOT NULL,
    sts_value real,
    sts_dateupdate timestamp without time zone
);


ALTER TABLE public.sitetimeslot OWNER TO axelor;

--
-- Name: staticparam; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE staticparam (
    static_ithreshold real NOT NULL,
    static_id integer NOT NULL,
    terminal_id integer NOT NULL,
    static_lateststart real NOT NULL,
    static_state character varying(10) NOT NULL,
    static_dinitial real NOT NULL,
    static_interruptmax real NOT NULL,
    static_nointerrupttime real NOT NULL,
    static_interruptactivecycle boolean NOT NULL,
    static_powerphasetocut real NOT NULL,
    static_dendcyclewindow real NOT NULL,
    static_iidlethreshold real NOT NULL,
    static_validityfrom timestamp without time zone,
    static_validityto timestamp without time zone,
    static_name character varying(50) NOT NULL
);


ALTER TABLE public.staticparam OWNER TO axelor;

--
-- Name: submeter; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE submeter (
    submeter_identifier character varying(50) NOT NULL,
    submeter_state character varying(10) NOT NULL,
    submeter_id integer NOT NULL,
    site_id integer NOT NULL,
    submodel_id integer NOT NULL,
    ctmodel_id integer NOT NULL,
    submeter_version character varying(10) NOT NULL,
    coffret_id integer
);


ALTER TABLE public.submeter OWNER TO axelor;

--
-- Name: submetermark; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE submetermark (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE public.submetermark OWNER TO postgres;

--
-- Name: submetermodel; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE submetermodel (
    submodel_mark character varying(50) NOT NULL,
    submodel_model character varying(50) NOT NULL,
    submodel_id integer NOT NULL,
    submodel_ct integer DEFAULT 1,
    submodel_resistance double precision DEFAULT 15 NOT NULL,
    mark_id integer
);


ALTER TABLE public.submetermodel OWNER TO axelor;

--
-- Name: supplier; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE supplier (
    supplier_id integer NOT NULL,
    supplier_name character varying(50) NOT NULL,
    supplier_country character varying(50) NOT NULL,
    supplier_website character varying(2083),
    supplier_currency character varying(5) NOT NULL,
    supplier_firstname character varying(50),
    supplier_surname character varying(50),
    supplier_occupation character varying(50),
    supplier_email character varying(50),
    supplier_phone character varying(50),
    supplier_mobile character varying(50),
    supplier_npa character varying(50) NOT NULL,
    supplier_tva double precision DEFAULT 0 NOT NULL
);


ALTER TABLE public.supplier OWNER TO axelor;

--
-- Name: tarification; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE tarification (
    tarif_id integer NOT NULL,
    tarif_name character varying(50) NOT NULL,
    tarif_year integer NOT NULL,
    tarif_consumption real NOT NULL,
    tarif_power real NOT NULL,
    tarif_subscription real NOT NULL,
    tarif_hasoneseason boolean NOT NULL,
    supplier_id integer NOT NULL,
    tarif_voltagetype character varying(50) NOT NULL,
    tarif_power_op character varying(10) NOT NULL,
    tarif_consumption_op character varying(10) NOT NULL,
    tarif_status character varying(50) NOT NULL,
    tarif_coefco2 real,
    tarif_priceco2 real
);


ALTER TABLE public.tarification OWNER TO axelor;

--
-- Name: tarificationparam; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE tarificationparam (
    season_id integer NOT NULL,
    tp_id integer NOT NULL,
    tp_name character varying(50) NOT NULL,
    tp_status character varying(50) NOT NULL,
    tp_slot_count integer NOT NULL,
    tp_type integer NOT NULL
);


ALTER TABLE public.tarificationparam OWNER TO axelor;

--
-- Name: temporairevaluesrcp; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE temporairevaluesrcp (
    temporairevaluesrcp_id integer NOT NULL,
    measurpoint_id integer,
    vcc double precision,
    vcp double precision,
    vcr double precision,
    puissance double precision,
    type integer,
    mesures_date timestamp without time zone,
    month integer,
    year integer
);


ALTER TABLE public.temporairevaluesrcp OWNER TO axelor;

--
-- Name: temporairevaluesrcp_temporairevaluesrcp_id_seq; Type: SEQUENCE; Schema: public; Owner: axelor
--

CREATE SEQUENCE temporairevaluesrcp_temporairevaluesrcp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.temporairevaluesrcp_temporairevaluesrcp_id_seq OWNER TO axelor;

--
-- Name: temporairevaluesrcp_temporairevaluesrcp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: axelor
--

ALTER SEQUENCE temporairevaluesrcp_temporairevaluesrcp_id_seq OWNED BY temporairevaluesrcp.temporairevaluesrcp_id;


--
-- Name: ter19; Type: VIEW; Schema: public; Owner: axelor
--

CREATE VIEW ter19 AS
    SELECT mesureparam.mesure_id, mesureparam.mesure_terminal_identifier, mesureparam.mesure_datetime, mesureparam.mesure_iph1, mesureparam.mesure_iph2, mesureparam.mesure_iph3, mesureparam.mesure_ip, mesureparam.mesure_ipp, mesureparam.mesure_uph1, mesureparam.mesure_uph2, mesureparam.mesure_uph3, mesureparam.mesure_up, mesureparam.mesure_upp, mesureparam.mesure_f, mesureparam.mesure_pa, mesureparam.mesure_pav, mesureparam.mesure_pr, mesureparam.mesure_ec, mesureparam.mesure_eg, mesureparam.mesure_erc, mesureparam.mesure_erg, mesureparam.mesure_phirad, mesureparam.mesure_cosphi, mesureparam.mesure_phideg, mesureparam.mesure_decisiondatetime, mesureparam.terminal_id, mesureparam.mesure_decisionstate, mesureparam.mesure_eac, mesureparam.mesure_eag, mesureparam.mesure_e1c, mesureparam.mesure_e1g FROM mesureparam WHERE (((mesureparam.mesure_datetime >= '2020-02-01 00:00:00'::timestamp without time zone) AND (mesureparam.mesure_datetime <= '2020-02-10 00:00:00'::timestamp without time zone)) AND (mesureparam.mesure_terminal_identifier = 19));


ALTER TABLE public.ter19 OWNER TO axelor;

--
-- Name: terminal; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE terminal (
    terminal_identifier character varying(50),
    terminal_number integer NOT NULL,
    terminal_state character varying(20) NOT NULL,
    terminal_id integer NOT NULL,
    ctmodel_id integer,
    terminalmodel_id integer NOT NULL,
    gateway_id integer NOT NULL,
    machine_id integer NOT NULL,
    terminal_version character varying(10) NOT NULL,
    rely_id integer,
    terminal_curparam integer,
    terminal_newparam integer,
    terminal_identifier2 character varying(50),
    coffret_id integer
);


ALTER TABLE public.terminal OWNER TO axelor;

--
-- Name: terminalmark; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE terminalmark (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE public.terminalmark OWNER TO postgres;

--
-- Name: terminalmodel; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE terminalmodel (
    terminalmodel_mark character varying(50) NOT NULL,
    terminalmodel_model character varying(50) NOT NULL,
    terminalmodel_id integer NOT NULL,
    terminalmodel_powercuttype character varying(20) NOT NULL,
    terminalmodel_phase character varying(20) NOT NULL,
    terminalmodel_maximumcurrent real NOT NULL,
    terminalmodel_ct integer DEFAULT 1,
    terminalmodel_resistance double precision DEFAULT 15 NOT NULL,
    mark_id integer
);


ALTER TABLE public.terminalmodel OWNER TO axelor;

--
-- Name: terminalstats; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE terminalstats (
    terminal_id integer NOT NULL,
    current_qh_value double precision,
    current_qh_start timestamp without time zone,
    current_qh_end timestamp without time zone,
    current_energy_value double precision,
    current_energy_start timestamp without time zone,
    last_measurement_date timestamp without time zone
);


ALTER TABLE public.terminalstats OWNER TO axelor;

--
-- Name: timer; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE timer (
    id integer NOT NULL,
    day text,
    start_period time without time zone,
    end_period time without time zone,
    rank integer,
    date timestamp without time zone,
    terminal_id integer,
    timer_mode boolean,
    eco_mode boolean
);


ALTER TABLE public.timer OWNER TO axelor;

--
-- Name: timer_modification_history; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE timer_modification_history (
    id integer NOT NULL,
    customer_id integer,
    timer_id integer,
    comment text,
    ecomode text,
    timermode text,
    date timestamp without time zone
);


ALTER TABLE public.timer_modification_history OWNER TO axelor;

--
-- Name: timervm; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE timervm (
    terminal_id integer NOT NULL,
    timervm_id integer NOT NULL,
    timervm_on_mo boolean NOT NULL,
    timervm_on_tu boolean NOT NULL,
    timervm_on_we boolean NOT NULL,
    timervm_on_th boolean NOT NULL,
    timervm_on_fr boolean NOT NULL,
    timervm_on_sa boolean NOT NULL,
    timervm_on_su boolean NOT NULL,
    timervm_on_time integer NOT NULL,
    timervm_off_mo boolean NOT NULL,
    timervm_off_tu boolean NOT NULL,
    timervm_off_we boolean NOT NULL,
    timervm_off_th boolean NOT NULL,
    timervm_off_fr boolean NOT NULL,
    timervm_off_sa boolean NOT NULL,
    timervm_off_su boolean NOT NULL,
    timervm_off_time integer NOT NULL,
    timervm_dutycycle integer NOT NULL,
    timervm_period integer NOT NULL,
    timervm_ontime integer NOT NULL,
    timervm_statusvm character varying(20) DEFAULT 'new'::character varying NOT NULL,
    timervm_datetimevm timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL,
    timervm_statusgw character varying(20) DEFAULT 'new'::character varying NOT NULL,
    timervm_datetimegw timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL
);


ALTER TABLE public.timervm OWNER TO axelor;

--
-- Name: timeslot; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE timeslot (
    timeslot_id integer NOT NULL,
    timeslot_name character varying(50) NOT NULL,
    timeslot_abbr character varying(50) NOT NULL,
    timeslot_tarif real NOT NULL,
    timeslot_unit character varying(10) NOT NULL,
    tp_id integer NOT NULL
);


ALTER TABLE public.timeslot OWNER TO axelor;

--
-- Name: timeslotinterval; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE timeslotinterval (
    tsi_id integer NOT NULL,
    tsi_day integer NOT NULL,
    tsi_start_hour integer NOT NULL,
    tsi_end_hour integer NOT NULL,
    timeslot_id integer NOT NULL
);


ALTER TABLE public.timeslotinterval OWNER TO axelor;

--
-- Name: transactionsrcp; Type: TABLE; Schema: public; Owner: axelor; Tablespace: 
--

CREATE TABLE transactionsrcp (
    transactions_id integer NOT NULL,
    measurpoint_idbuyer integer NOT NULL,
    measurpoint_idseller integer NOT NULL,
    transactions_energysold double precision NOT NULL,
    transactions_datestart timestamp without time zone NOT NULL,
    transactions_dateend timestamp without time zone NOT NULL,
    storedonserver boolean DEFAULT false
);


ALTER TABLE public.transactionsrcp OWNER TO axelor;

--
-- Name: transactionsrcp_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: axelor
--

CREATE SEQUENCE transactionsrcp_transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transactionsrcp_transactions_id_seq OWNER TO axelor;

--
-- Name: transactionsrcp_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: axelor
--

ALTER SEQUENCE transactionsrcp_transactions_id_seq OWNED BY transactionsrcp.transactions_id;


--
-- Name: user2axelorrole; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE user2axelorrole (
    user_id bigint NOT NULL,
    role_id bigint NOT NULL,
    site_id bigint NOT NULL
);


ALTER TABLE public.user2axelorrole OWNER TO postgres;

--
-- Name: vista; Type: VIEW; Schema: public; Owner: axelor
--

CREATE VIEW vista AS
    SELECT date_trunc('hour'::text, mesureparam.mesure_datetime) AS "Day", (max(mesureparam.mesure_ec) - min(mesureparam.mesure_ec)) AS cons FROM mesureparam WHERE (date_part('month'::text, mesureparam.mesure_datetime) = (9)::double precision) GROUP BY date_trunc('hour'::text, mesureparam.mesure_datetime) ORDER BY date_trunc('hour'::text, mesureparam.mesure_datetime);


ALTER TABLE public.vista OWNER TO axelor;

--
-- Name: client_id; Type: DEFAULT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY clientrcp ALTER COLUMN client_id SET DEFAULT nextval('clientrcp_client_id_seq'::regclass);


--
-- Name: fabricationorder_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY fabricationorder ALTER COLUMN fabricationorder_id SET DEFAULT nextval('fabricationorder_fabricationorder_id_seq'::regclass);


--
-- Name: fabricationorder_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY fabricationordervalue ALTER COLUMN fabricationorder_id SET DEFAULT nextval('fabricationordervalue_fabricationorder_id_seq'::regclass);


--
-- Name: facturedetail_id; Type: DEFAULT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY facturedetail ALTER COLUMN facturedetail_id SET DEFAULT nextval('facturedetail_facturedetail_id_seq'::regclass);


--
-- Name: machinealgoparam_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY machinealgoparam ALTER COLUMN machinealgoparam_id SET DEFAULT nextval('machinealgoparam_machinealgoparam_id_seq'::regclass);


--
-- Name: machinealgoparamlist_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY machinealgoparamlist ALTER COLUMN machinealgoparamlist_id SET DEFAULT nextval('machinealgoparamlist_machinealgoparamlist_id_seq'::regclass);


--
-- Name: measurpoint_id; Type: DEFAULT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY measurpointrcp ALTER COLUMN measurpoint_id SET DEFAULT nextval('measurpointrcp_measurpoint_id_seq'::regclass);


--
-- Name: mesure_id; Type: DEFAULT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY mesuresrcp ALTER COLUMN mesure_id SET DEFAULT nextval('mesuresrcp_mesure_id_seq'::regclass);


--
-- Name: temporairevaluesrcp_id; Type: DEFAULT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY temporairevaluesrcp ALTER COLUMN temporairevaluesrcp_id SET DEFAULT nextval('temporairevaluesrcp_temporairevaluesrcp_id_seq'::regclass);


--
-- Name: transactions_id; Type: DEFAULT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY transactionsrcp ALTER COLUMN transactions_id SET DEFAULT nextval('transactionsrcp_transactions_id_seq'::regclass);


--
-- Name: addressrcp_pkey; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY addressrcp
    ADD CONSTRAINT addressrcp_pkey PRIMARY KEY (address_id);


--
-- Name: algoconfig_pkey; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY algoconfig
    ADD CONSTRAINT algoconfig_pkey PRIMARY KEY (algoconfig_id);


--
-- Name: algoparam_pkey; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY algoparam
    ADD CONSTRAINT algoparam_pkey PRIMARY KEY (algoparam_id, algoconfig_id);


--
-- Name: armoire_pkey; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY armoire
    ADD CONSTRAINT armoire_pkey PRIMARY KEY (armoire_id);


--
-- Name: bridgemark-pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bridgemark
    ADD CONSTRAINT "bridgemark-pk" PRIMARY KEY (id);


--
-- Name: building_pkey; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY building
    ADD CONSTRAINT building_pkey PRIMARY KEY (building_id);


--
-- Name: clientrcp_pkey; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY clientrcp
    ADD CONSTRAINT clientrcp_pkey PRIMARY KEY (client_id);


--
-- Name: coffret_pkey; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY coffret
    ADD CONSTRAINT coffret_pkey PRIMARY KEY (coffret_id);


--
-- Name: coffretmark-pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY coffretmark
    ADD CONSTRAINT "coffretmark-pk" PRIMARY KEY (id);


--
-- Name: coffretmodel_pkey; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY coffretmodel
    ADD CONSTRAINT coffretmodel_pkey PRIMARY KEY (coffretmodel_id);


--
-- Name: comment_pkey; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (comm_id);


--
-- Name: ctmark-pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ctmark
    ADD CONSTRAINT "ctmark-pk" PRIMARY KEY (id);


--
-- Name: device2measuregroup-pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY device2measuregroup
    ADD CONSTRAINT "device2measuregroup-pk" PRIMARY KEY (id);


--
-- Name: devicegroup-pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY measuregroup
    ADD CONSTRAINT "devicegroup-pk" PRIMARY KEY (id);


--
-- Name: fabricationorder_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY fabricationorder
    ADD CONSTRAINT fabricationorder_pkey PRIMARY KEY (fabricationorder_id);


--
-- Name: fabricationordervalue_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY fabricationordervalue
    ADD CONSTRAINT fabricationordervalue_pkey PRIMARY KEY (fabricationorder_id, sensor_id);


--
-- Name: facturationref_pkey; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY facturationref
    ADD CONSTRAINT facturationref_pkey PRIMARY KEY (site_id, facturationref_date, timeslot_id);


--
-- Name: facturedetail_facture_num_detailtruct_id_key; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY facturedetail
    ADD CONSTRAINT facturedetail_facture_num_detailtruct_id_key UNIQUE (facture_num, detailtruct_id);


--
-- Name: facturedetail_pkey; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY facturedetail
    ADD CONSTRAINT facturedetail_pkey PRIMARY KEY (facturedetail_id);


--
-- Name: facturedetailstruct_pkey; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY facturedetailstruct
    ADD CONSTRAINT facturedetailstruct_pkey PRIMARY KEY (detailtruct_id);


--
-- Name: facturercp_facture_year_facture_month_measurpoint_id_client_key; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY facturercp
    ADD CONSTRAINT facturercp_facture_year_facture_month_measurpoint_id_client_key UNIQUE (facture_year, facture_month, measurpoint_id, client_id);


--
-- Name: facturercp_pkey; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY facturercp
    ADD CONSTRAINT facturercp_pkey PRIMARY KEY (facture_num);


--
-- Name: gatewaymark-pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gatewaymark
    ADD CONSTRAINT "gatewaymark-pk" PRIMARY KEY (id);


--
-- Name: grappe-pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY grappe
    ADD CONSTRAINT "grappe-pk" PRIMARY KEY (id);


--
-- Name: igmark-pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY igmark
    ADD CONSTRAINT "igmark-pk" PRIMARY KEY (id);


--
-- Name: installer_pkey; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY installer
    ADD CONSTRAINT installer_pkey PRIMARY KEY (inst_id);


--
-- Name: license_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY license
    ADD CONSTRAINT license_pk PRIMARY KEY (id);


--
-- Name: machine_machine_ofid_key; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY machine
    ADD CONSTRAINT machine_machine_ofid_key UNIQUE (machine_ofid);


--
-- Name: machinealgoparam_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY machinealgoparam
    ADD CONSTRAINT machinealgoparam_pkey PRIMARY KEY (machinealgoparam_id);


--
-- Name: machinealgoparamlist_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY machinealgoparamlist
    ADD CONSTRAINT machinealgoparamlist_pkey PRIMARY KEY (machinealgoparamlist_id);


--
-- Name: machinealgoparamvalue_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY machinealgoparamvalue
    ADD CONSTRAINT machinealgoparamvalue_pk PRIMARY KEY (machinealgoparamvalue_machinealgoparam_id, machinealgoparamvalue_machinealgoparamlist_id);


--
-- Name: measurpointrcp_pkey; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY measurpointrcp
    ADD CONSTRAINT measurpointrcp_pkey PRIMARY KEY (measurpoint_id);


--
-- Name: menugroup2customer_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY menugroup2customer
    ADD CONSTRAINT menugroup2customer_pk PRIMARY KEY (customer_id, menu_id, license_id);


--
-- Name: menugroup_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY menugroup
    ADD CONSTRAINT menugroup_pk PRIMARY KEY (id);


--
-- Name: mesuresrcp_measurpoint_id_mesures_date_key; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY mesuresrcp
    ADD CONSTRAINT mesuresrcp_measurpoint_id_mesures_date_key UNIQUE (measurpoint_id, mesures_date);


--
-- Name: mesuresrcp_pkey; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY mesuresrcp
    ADD CONSTRAINT mesuresrcp_pkey PRIMARY KEY (mesure_id);


--
-- Name: pk_administrator; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY administrator
    ADD CONSTRAINT pk_administrator PRIMARY KEY (admin_id);


--
-- Name: pk_bridge; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY bridge
    ADD CONSTRAINT pk_bridge PRIMARY KEY (bridge_id);


--
-- Name: pk_bridgemodel; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY bridgemodel
    ADD CONSTRAINT pk_bridgemodel PRIMARY KEY (bridgemodel_id);


--
-- Name: pk_configparam; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY configparam
    ADD CONSTRAINT pk_configparam PRIMARY KEY (configparam_id);


--
-- Name: pk_ctmodel; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY ctmodel
    ADD CONSTRAINT pk_ctmodel PRIMARY KEY (ctmodel_id);


--
-- Name: pk_customer; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY customer
    ADD CONSTRAINT pk_customer PRIMARY KEY (customer_id);


--
-- Name: pk_customerorder; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY customerorder
    ADD CONSTRAINT pk_customerorder PRIMARY KEY (order_id);


--
-- Name: pk_gateway; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY gateway
    ADD CONSTRAINT pk_gateway PRIMARY KEY (gateway_id);


--
-- Name: pk_gatewaymodel; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY gatewaymodel
    ADD CONSTRAINT pk_gatewaymodel PRIMARY KEY (gwmodel_id);


--
-- Name: pk_ig; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY ig
    ADD CONSTRAINT pk_ig PRIMARY KEY (ig_id);


--
-- Name: pk_igmodel; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY igmodel
    ADD CONSTRAINT pk_igmodel PRIMARY KEY (igmodel_id);


--
-- Name: pk_ismodbus; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY ismodbus
    ADD CONSTRAINT pk_ismodbus PRIMARY KEY (ismodbus_id);


--
-- Name: pk_ismodbusmodel; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY ismodbusmodel
    ADD CONSTRAINT pk_ismodbusmodel PRIMARY KEY (ismodbusmodel_id);


--
-- Name: pk_machine; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY machine
    ADD CONSTRAINT pk_machine PRIMARY KEY (machine_id);


--
-- Name: pk_machinetype; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY machinetype
    ADD CONSTRAINT pk_machinetype PRIMARY KEY (machinetype_id);


--
-- Name: pk_maintenance; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY maintenance
    ADD CONSTRAINT pk_maintenance PRIMARY KEY (maintenance_id);


--
-- Name: pk_mesureparam; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY mesureparam
    ADD CONSTRAINT pk_mesureparam PRIMARY KEY (mesure_terminal_identifier, mesure_datetime);


--
-- Name: pk_orderitem; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY orderitem
    ADD CONSTRAINT pk_orderitem PRIMARY KEY (item_id);


--
-- Name: pk_pagecategory; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY pagecategory
    ADD CONSTRAINT pk_pagecategory PRIMARY KEY (cat_id);


--
-- Name: pk_pages; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY page
    ADD CONSTRAINT pk_pages PRIMARY KEY (page_id);


--
-- Name: pk_paramtarification; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY tarificationparam
    ADD CONSTRAINT pk_paramtarification PRIMARY KEY (tp_id);


--
-- Name: pk_partner; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY partner
    ADD CONSTRAINT pk_partner PRIMARY KEY (partner_id);


--
-- Name: pk_partnerinstaller; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY partnerinstaller
    ADD CONSTRAINT pk_partnerinstaller PRIMARY KEY (partner_id, inst_id);


--
-- Name: pk_permission; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY permission
    ADD CONSTRAINT pk_permission PRIMARY KEY (permission_id);


--
-- Name: pk_product; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY product
    ADD CONSTRAINT pk_product PRIMARY KEY (product_id);


--
-- Name: pk_rely; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY rely
    ADD CONSTRAINT pk_rely PRIMARY KEY (rely_id);


--
-- Name: pk_roles; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT pk_roles PRIMARY KEY (role_id);


--
-- Name: pk_scmesureparam; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY scmesureparam
    ADD CONSTRAINT pk_scmesureparam PRIMARY KEY (mesure_submeter_identifier, mesure_datetime);


--
-- Name: pk_scmodel; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY submetermodel
    ADD CONSTRAINT pk_scmodel PRIMARY KEY (submodel_id);


--
-- Name: pk_season; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY season
    ADD CONSTRAINT pk_season PRIMARY KEY (season_id);


--
-- Name: pk_sensor; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY sensor
    ADD CONSTRAINT pk_sensor PRIMARY KEY (sensor_id);


--
-- Name: pk_sensormeasurement; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY sensormeasurement
    ADD CONSTRAINT pk_sensormeasurement PRIMARY KEY (sensormeasurement_datetime, sensor_id);


--
-- Name: pk_sensormodel; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY sensormodel
    ADD CONSTRAINT pk_sensormodel PRIMARY KEY (sensormodel_id);


--
-- Name: pk_sensorterminal; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY sensorterminal
    ADD CONSTRAINT pk_sensorterminal PRIMARY KEY (terminal_id, sensor_id);


--
-- Name: pk_site; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY site
    ADD CONSTRAINT pk_site PRIMARY KEY (site_id);


--
-- Name: pk_sitetarification; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY sitetarification
    ADD CONSTRAINT pk_sitetarification PRIMARY KEY (site_id, tarif_id);


--
-- Name: pk_sitetimeslot; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY sitetimeslot
    ADD CONSTRAINT pk_sitetimeslot PRIMARY KEY (site_id, timeslot_id);


--
-- Name: pk_staticparam; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY staticparam
    ADD CONSTRAINT pk_staticparam PRIMARY KEY (static_id);


--
-- Name: pk_submeter; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY submeter
    ADD CONSTRAINT pk_submeter PRIMARY KEY (submeter_id);


--
-- Name: pk_terminal; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY terminal
    ADD CONSTRAINT pk_terminal PRIMARY KEY (terminal_id);


--
-- Name: pk_terminalmodel; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY terminalmodel
    ADD CONSTRAINT pk_terminalmodel PRIMARY KEY (terminalmodel_id);


--
-- Name: pk_timer_vm; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY timervm
    ADD CONSTRAINT pk_timer_vm PRIMARY KEY (terminal_id, timervm_id);


--
-- Name: pk_timeslot; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY timeslot
    ADD CONSTRAINT pk_timeslot PRIMARY KEY (timeslot_id);


--
-- Name: pk_timeslotinterval; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY timeslotinterval
    ADD CONSTRAINT pk_timeslotinterval PRIMARY KEY (tsi_id);


--
-- Name: powersupply_pkey; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY powersupply
    ADD CONSTRAINT powersupply_pkey PRIMARY KEY (powersupply_id);


--
-- Name: powersupplymodel_pkey; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY powersupplymodel
    ADD CONSTRAINT powersupplymodel_pkey PRIMARY KEY (powersupplymodel_id);


--
-- Name: reportEnergy_pkey; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY reportenergy
    ADD CONSTRAINT "reportEnergy_pkey" PRIMARY KEY (terminal_id, energy_timestamp);


--
-- Name: reportLoad_pkey; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY reportload
    ADD CONSTRAINT "reportLoad_pkey" PRIMARY KEY (terminal_id, load_timestamp);


--
-- Name: reportPower_pkey; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY reportpower
    ADD CONSTRAINT "reportPower_pkey" PRIMARY KEY (terminal_id, power_timestamp);


--
-- Name: reversemesureparam_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY reversemesureparam
    ADD CONSTRAINT reversemesureparam_pkey PRIMARY KEY (terminal_id, mesure_datetime);


--
-- Name: reverseparam_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY reverseparam
    ADD CONSTRAINT reverseparam_pkey PRIMARY KEY (terminal_id, rp_profile_type);


--
-- Name: schema_version_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY schema_version
    ADD CONSTRAINT schema_version_pk PRIMARY KEY (installed_rank);


--
-- Name: axelorrole2menugroup_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY axelorrole2menugroup
    ADD CONSTRAINT axelorrole2menugroup_pk PRIMARY KEY (role_id, menu_id);


--
-- Name: axelorrole_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY axelorrole
    ADD CONSTRAINT axelorrole_pk PRIMARY KEY (id);


--
-- Name: axeloruser_login_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY axeloruser
    ADD CONSTRAINT axeloruser_login_key UNIQUE (login);


--
-- Name: axeloruser_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY axeloruser
    ADD CONSTRAINT axeloruser_pk PRIMARY KEY (id);


--
-- Name: sensor2measuregroup-pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY sensor2measuregroup
    ADD CONSTRAINT "sensor2measuregroup-pk" PRIMARY KEY (id);


--
-- Name: submetermark-pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY submetermark
    ADD CONSTRAINT "submetermark-pk" PRIMARY KEY (id);


--
-- Name: supplier_pkey; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY supplier
    ADD CONSTRAINT supplier_pkey PRIMARY KEY (supplier_id);


--
-- Name: tarification_pkey; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY tarification
    ADD CONSTRAINT tarification_pkey PRIMARY KEY (tarif_id);


--
-- Name: temporairevaluesrcp_measurpoint_id_type_key; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY temporairevaluesrcp
    ADD CONSTRAINT temporairevaluesrcp_measurpoint_id_type_key UNIQUE (measurpoint_id, type);


--
-- Name: temporairevaluesrcp_pkey; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY temporairevaluesrcp
    ADD CONSTRAINT temporairevaluesrcp_pkey PRIMARY KEY (temporairevaluesrcp_id);


--
-- Name: terminalmark-pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY terminalmark
    ADD CONSTRAINT "terminalmark-pk" PRIMARY KEY (id);


--
-- Name: terminalstats_pkey; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY terminalstats
    ADD CONSTRAINT terminalstats_pkey PRIMARY KEY (terminal_id);


--
-- Name: timer-pk; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY timer
    ADD CONSTRAINT "timer-pk" PRIMARY KEY (id);


--
-- Name: timer_modification_history_pk; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY timer_modification_history
    ADD CONSTRAINT timer_modification_history_pk PRIMARY KEY (id);


--
-- Name: transactionsrcp_measurpoint_idbuyer_measurpoint_idseller_tr_key; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY transactionsrcp
    ADD CONSTRAINT transactionsrcp_measurpoint_idbuyer_measurpoint_idseller_tr_key UNIQUE (measurpoint_idbuyer, measurpoint_idseller, transactions_datestart, transactions_dateend);


--
-- Name: transactionsrcp_pkey; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY transactionsrcp
    ADD CONSTRAINT transactionsrcp_pkey PRIMARY KEY (transactions_id);


--
-- Name: unique_customer_login; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY customer
    ADD CONSTRAINT unique_customer_login UNIQUE (customer_login);


--
-- Name: uq_administrator_admin_id; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY administrator
    ADD CONSTRAINT uq_administrator_admin_id UNIQUE (admin_id);


--
-- Name: uq_administrator_admin_username; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY administrator
    ADD CONSTRAINT uq_administrator_admin_username UNIQUE (admin_username);


--
-- Name: uq_ctmodel_ctmodel_id; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY ctmodel
    ADD CONSTRAINT uq_ctmodel_ctmodel_id UNIQUE (ctmodel_id);


--
-- Name: uq_customer_customer_id; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY customer
    ADD CONSTRAINT uq_customer_customer_id UNIQUE (customer_id);


--
-- Name: uq_customerorder_order_id; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY customerorder
    ADD CONSTRAINT uq_customerorder_order_id UNIQUE (order_id);


--
-- Name: uq_gateway_gateway_id; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY gateway
    ADD CONSTRAINT uq_gateway_gateway_id UNIQUE (gateway_id);


--
-- Name: uq_gatewaymodel_gwmodel_id; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY gatewaymodel
    ADD CONSTRAINT uq_gatewaymodel_gwmodel_id UNIQUE (gwmodel_id);


--
-- Name: uq_machine_machine_id; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY machine
    ADD CONSTRAINT uq_machine_machine_id UNIQUE (machine_id);


--
-- Name: uq_machinetype_machinetype_id; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY machinetype
    ADD CONSTRAINT uq_machinetype_machinetype_id UNIQUE (machinetype_id);


--
-- Name: uq_mesureparam_mesure_id; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY mesureparam
    ADD CONSTRAINT uq_mesureparam_mesure_id UNIQUE (mesure_id);


--
-- Name: uq_orderitem_item_id; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY orderitem
    ADD CONSTRAINT uq_orderitem_item_id UNIQUE (item_id);


--
-- Name: uq_pages_page_id; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY page
    ADD CONSTRAINT uq_pages_page_id UNIQUE (page_id);


--
-- Name: uq_partner_partner_id; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY partner
    ADD CONSTRAINT uq_partner_partner_id UNIQUE (partner_id);


--
-- Name: uq_permission_permission_id; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY permission
    ADD CONSTRAINT uq_permission_permission_id UNIQUE (permission_id);


--
-- Name: uq_product_product_id; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY product
    ADD CONSTRAINT uq_product_product_id UNIQUE (product_id);


--
-- Name: uq_rely_rely_id; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY rely
    ADD CONSTRAINT uq_rely_rely_id UNIQUE (rely_id);


--
-- Name: uq_roles_role_id; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT uq_roles_role_id UNIQUE (role_id);


--
-- Name: uq_site_site_id; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY site
    ADD CONSTRAINT uq_site_site_id UNIQUE (site_id);


--
-- Name: uq_submeter_submeter_id; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY submeter
    ADD CONSTRAINT uq_submeter_submeter_id UNIQUE (submeter_id);


--
-- Name: uq_submetermodel_submodel_id; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY submetermodel
    ADD CONSTRAINT uq_submetermodel_submodel_id UNIQUE (submodel_id);


--
-- Name: uq_terminal_terminal_id; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY terminal
    ADD CONSTRAINT uq_terminal_terminal_id UNIQUE (terminal_id);


--
-- Name: uq_terminalmodel_terminalmodel_id; Type: CONSTRAINT; Schema: public; Owner: axelor; Tablespace: 
--

ALTER TABLE ONLY terminalmodel
    ADD CONSTRAINT uq_terminalmodel_terminalmodel_id UNIQUE (terminalmodel_id);


--
-- Name: user2axelorrole_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user2axelorrole
    ADD CONSTRAINT user2axelorrole_pk PRIMARY KEY (user_id, role_id, site_id);


--
-- Name: fki_administrator_partner; Type: INDEX; Schema: public; Owner: axelor; Tablespace: 
--

CREATE INDEX fki_administrator_partner ON administrator USING btree (partner_id);


--
-- Name: fki_instId; Type: INDEX; Schema: public; Owner: axelor; Tablespace: 
--

CREATE INDEX "fki_instId" ON comment USING btree (inst_id);


--
-- Name: fki_instId_fk; Type: INDEX; Schema: public; Owner: axelor; Tablespace: 
--

CREATE INDEX "fki_instId_fk" ON site USING btree (inst_id);


--
-- Name: fki_partner_customer; Type: INDEX; Schema: public; Owner: axelor; Tablespace: 
--

CREATE INDEX fki_partner_customer ON customer USING btree (partner_id);


--
-- Name: fki_partner_product; Type: INDEX; Schema: public; Owner: axelor; Tablespace: 
--

CREATE INDEX fki_partner_product ON product USING btree (partner_id);


--
-- Name: fki_rely_terminal; Type: INDEX; Schema: public; Owner: axelor; Tablespace: 
--

CREATE INDEX fki_rely_terminal ON terminal USING btree (rely_id);


--
-- Name: fki_siteId; Type: INDEX; Schema: public; Owner: axelor; Tablespace: 
--

CREATE INDEX "fki_siteId" ON comment USING btree (site_id);


--
-- Name: fki_terminal_configparam; Type: INDEX; Schema: public; Owner: axelor; Tablespace: 
--

CREATE INDEX fki_terminal_configparam ON configparam USING btree (terminal_id);


--
-- Name: idx_load_timestamp; Type: INDEX; Schema: public; Owner: axelor; Tablespace: 
--

CREATE INDEX idx_load_timestamp ON reportload USING btree (terminal_id, load_timestamp);


--
-- Name: idx_submeter_timestamp; Type: INDEX; Schema: public; Owner: axelor; Tablespace: 
--

CREATE INDEX idx_submeter_timestamp ON scmesureparam USING btree (mesure_submeter_identifier, mesure_datetime);


--
-- Name: idx_terminal_timestamp; Type: INDEX; Schema: public; Owner: axelor; Tablespace: 
--

CREATE INDEX idx_terminal_timestamp ON mesureparam USING btree (mesure_terminal_identifier, mesure_datetime);


--
-- Name: schema_version_s_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX schema_version_s_idx ON schema_version USING btree (success);


--
-- Name: algoconfig_machine_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY algoconfig
    ADD CONSTRAINT algoconfig_machine_id_fkey FOREIGN KEY (machine_id) REFERENCES machine(machine_id);


--
-- Name: algoparam_algoconfig_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY algoparam
    ADD CONSTRAINT algoparam_algoconfig_id_fkey FOREIGN KEY (algoconfig_id) REFERENCES algoconfig(algoconfig_id);


--
-- Name: armoire_building_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY armoire
    ADD CONSTRAINT armoire_building_id_fkey FOREIGN KEY (building_id) REFERENCES building(building_id);


--
-- Name: bridge_coffret_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY bridge
    ADD CONSTRAINT bridge_coffret_id_fkey FOREIGN KEY (coffret_id) REFERENCES coffret(coffret_id);


--
-- Name: bridgemark-fk; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY bridgemodel
    ADD CONSTRAINT "bridgemark-fk" FOREIGN KEY (bridgemark_id) REFERENCES bridgemark(id);


--
-- Name: building_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY building
    ADD CONSTRAINT building_site_id_fkey FOREIGN KEY (site_id) REFERENCES site(site_id);


--
-- Name: clientrcp_address_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY clientrcp
    ADD CONSTRAINT clientrcp_address_id_fkey FOREIGN KEY (address_id) REFERENCES addressrcp(address_id);


--
-- Name: clientrcp_measurpoint_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY clientrcp
    ADD CONSTRAINT clientrcp_measurpoint_id_fkey FOREIGN KEY (measurpoint_id) REFERENCES measurpointrcp(measurpoint_id);


--
-- Name: coffret-grappe-fk; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY coffret
    ADD CONSTRAINT "coffret-grappe-fk" FOREIGN KEY (grappe_id) REFERENCES grappe(id);


--
-- Name: coffret-terminal-fk; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY terminal
    ADD CONSTRAINT "coffret-terminal-fk" FOREIGN KEY (coffret_id) REFERENCES coffret(coffret_id);


--
-- Name: coffret_armoire_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY coffret
    ADD CONSTRAINT coffret_armoire_id_fkey FOREIGN KEY (armoire_id) REFERENCES armoire(armoire_id);


--
-- Name: coffret_coffretmodel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY coffret
    ADD CONSTRAINT coffret_coffretmodel_id_fkey FOREIGN KEY (coffretmodel_id) REFERENCES coffretmodel(coffretmodel_id);


--
-- Name: coffret_powersupply_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY coffret
    ADD CONSTRAINT coffret_powersupply_id_fkey FOREIGN KEY (powersupply_id) REFERENCES powersupply(powersupply_id);


--
-- Name: coffretmark-fk; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY coffretmodel
    ADD CONSTRAINT "coffretmark-fk" FOREIGN KEY (coffretmark_id) REFERENCES coffretmark(id);


--
-- Name: ctmark-fk; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY ctmodel
    ADD CONSTRAINT "ctmark-fk" FOREIGN KEY (mark_id) REFERENCES ctmark(id);


--
-- Name: customer_modification_history_fk; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY timer_modification_history
    ADD CONSTRAINT customer_modification_history_fk FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fabricationorder_fabricationorder_machine_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY fabricationorder
    ADD CONSTRAINT fabricationorder_fabricationorder_machine_fkey FOREIGN KEY (fabricationorder_machine) REFERENCES machine(machine_ofid);


--
-- Name: fabricationordervalue_fabricationorder_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY fabricationordervalue
    ADD CONSTRAINT fabricationordervalue_fabricationorder_id_fkey FOREIGN KEY (fabricationorder_id) REFERENCES fabricationorder(fabricationorder_id);


--
-- Name: fabricationordervalue_sensor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY fabricationordervalue
    ADD CONSTRAINT fabricationordervalue_sensor_id_fkey FOREIGN KEY (sensor_id) REFERENCES sensor(sensor_id);


--
-- Name: facturationref_facturationprice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY facturationref
    ADD CONSTRAINT facturationref_facturationprice_id_fkey FOREIGN KEY (timeslot_id) REFERENCES timeslot(timeslot_id);


--
-- Name: facturationref_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY facturationref
    ADD CONSTRAINT facturationref_site_id_fkey FOREIGN KEY (site_id) REFERENCES site(site_id);


--
-- Name: facturedetail_detailtruct_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY facturedetail
    ADD CONSTRAINT facturedetail_detailtruct_id_fkey FOREIGN KEY (detailtruct_id) REFERENCES facturedetailstruct(detailtruct_id);


--
-- Name: facturedetail_facture_num_fkey; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY facturedetail
    ADD CONSTRAINT facturedetail_facture_num_fkey FOREIGN KEY (facture_num) REFERENCES facturercp(facture_num);


--
-- Name: facturercp_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY facturercp
    ADD CONSTRAINT facturercp_client_id_fkey FOREIGN KEY (client_id) REFERENCES clientrcp(client_id);


--
-- Name: facturercp_measurpoint_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY facturercp
    ADD CONSTRAINT facturercp_measurpoint_id_fkey FOREIGN KEY (measurpoint_id) REFERENCES measurpointrcp(measurpoint_id);


--
-- Name: fk_administrator_installer; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY administrator
    ADD CONSTRAINT fk_administrator_installer FOREIGN KEY (inst_id) REFERENCES installer(inst_id);


--
-- Name: fk_administrator_partner; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY administrator
    ADD CONSTRAINT fk_administrator_partner FOREIGN KEY (partner_id) REFERENCES partner(partner_id);


--
-- Name: fk_administrator_roles; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY administrator
    ADD CONSTRAINT fk_administrator_roles FOREIGN KEY (role_id) REFERENCES roles(role_id);


--
-- Name: fk_bridge_bridgemodel; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY bridge
    ADD CONSTRAINT fk_bridge_bridgemodel FOREIGN KEY (bridgemodel_id) REFERENCES bridgemodel(bridgemodel_id);


--
-- Name: fk_bridge_gateway; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY bridge
    ADD CONSTRAINT fk_bridge_gateway FOREIGN KEY (gateway_id) REFERENCES gateway(gateway_id);


--
-- Name: fk_customerorder_site; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY customerorder
    ADD CONSTRAINT fk_customerorder_site FOREIGN KEY (site_id) REFERENCES site(site_id);


--
-- Name: fk_gateway_gatewaymodel; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY gateway
    ADD CONSTRAINT fk_gateway_gatewaymodel FOREIGN KEY (gwmodel_id) REFERENCES gatewaymodel(gwmodel_id);


--
-- Name: fk_gateway_site; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY gateway
    ADD CONSTRAINT fk_gateway_site FOREIGN KEY (site_id) REFERENCES site(site_id);


--
-- Name: fk_ig_igmodel; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY ig
    ADD CONSTRAINT fk_ig_igmodel FOREIGN KEY (igmodel_id) REFERENCES igmodel(igmodel_id);


--
-- Name: fk_ismodbus_gateway; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY ismodbus
    ADD CONSTRAINT fk_ismodbus_gateway FOREIGN KEY (gateway_id) REFERENCES gateway(gateway_id);


--
-- Name: fk_ismodbus_ismodbusmodel; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY ismodbus
    ADD CONSTRAINT fk_ismodbus_ismodbusmodel FOREIGN KEY (ismodbusmodel_id) REFERENCES ismodbusmodel(ismodbusmodel_id);


--
-- Name: fk_machine_machinetype; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY machine
    ADD CONSTRAINT fk_machine_machinetype FOREIGN KEY (machinetype_id) REFERENCES machinetype(machinetype_id);


--
-- Name: fk_machine_site; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY machine
    ADD CONSTRAINT fk_machine_site FOREIGN KEY (site_id) REFERENCES site(site_id);


--
-- Name: fk_maintenance_site; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY maintenance
    ADD CONSTRAINT fk_maintenance_site FOREIGN KEY (site_id) REFERENCES site(site_id);


--
-- Name: fk_mesureparam_terminal; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY mesureparam
    ADD CONSTRAINT fk_mesureparam_terminal FOREIGN KEY (terminal_id) REFERENCES terminal(terminal_id);


--
-- Name: fk_orderitem_customerorder; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY orderitem
    ADD CONSTRAINT fk_orderitem_customerorder FOREIGN KEY (order_id) REFERENCES customerorder(order_id);


--
-- Name: fk_orderitem_product; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY orderitem
    ADD CONSTRAINT fk_orderitem_product FOREIGN KEY (proudct_id) REFERENCES product(product_id);


--
-- Name: fk_page_pagecategory; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY page
    ADD CONSTRAINT fk_page_pagecategory FOREIGN KEY (cat_id) REFERENCES pagecategory(cat_id);


--
-- Name: fk_partner_customer; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY customer
    ADD CONSTRAINT fk_partner_customer FOREIGN KEY (partner_id) REFERENCES partner(partner_id);


--
-- Name: fk_partner_product; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY product
    ADD CONSTRAINT fk_partner_product FOREIGN KEY (partner_id) REFERENCES partner(partner_id);


--
-- Name: fk_partnerinstaller_installer; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY partnerinstaller
    ADD CONSTRAINT fk_partnerinstaller_installer FOREIGN KEY (inst_id) REFERENCES installer(inst_id);


--
-- Name: fk_partnerinstaller_partner; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY partnerinstaller
    ADD CONSTRAINT fk_partnerinstaller_partner FOREIGN KEY (partner_id) REFERENCES partner(partner_id);


--
-- Name: fk_permission_page; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY permission
    ADD CONSTRAINT fk_permission_page FOREIGN KEY (page_id) REFERENCES page(page_id);


--
-- Name: fk_permission_roles; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY permission
    ADD CONSTRAINT fk_permission_roles FOREIGN KEY (roles_id) REFERENCES roles(role_id);


--
-- Name: fk_rely_terminal; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY terminal
    ADD CONSTRAINT fk_rely_terminal FOREIGN KEY (rely_id) REFERENCES rely(rely_id);


--
-- Name: fk_scmesureparam_submeter; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY scmesureparam
    ADD CONSTRAINT fk_scmesureparam_submeter FOREIGN KEY (submeter_id) REFERENCES submeter(submeter_id);


--
-- Name: fk_season_paramtarification; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY tarificationparam
    ADD CONSTRAINT fk_season_paramtarification FOREIGN KEY (season_id) REFERENCES season(season_id);


--
-- Name: fk_sensor_sensormodel; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY sensor
    ADD CONSTRAINT fk_sensor_sensormodel FOREIGN KEY (sensormodel_id) REFERENCES sensormodel(sensormodel_id);


--
-- Name: fk_sensor_signature; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sensor2measuregroup
    ADD CONSTRAINT fk_sensor_signature FOREIGN KEY (sensor_id) REFERENCES sensor(sensor_id);


--
-- Name: fk_sensor_signature; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY device2measuregroup
    ADD CONSTRAINT fk_sensor_signature FOREIGN KEY (sensor_id) REFERENCES sensor(sensor_id);


--
-- Name: fk_sensormeasurement_sensor; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY sensormeasurement
    ADD CONSTRAINT fk_sensormeasurement_sensor FOREIGN KEY (sensor_id) REFERENCES sensor(sensor_id);


--
-- Name: fk_sensorterminal_sensor; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY sensorterminal
    ADD CONSTRAINT fk_sensorterminal_sensor FOREIGN KEY (sensor_id) REFERENCES sensor(sensor_id);


--
-- Name: fk_sensorterminal_terminal; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY sensorterminal
    ADD CONSTRAINT fk_sensorterminal_terminal FOREIGN KEY (terminal_id) REFERENCES terminal(terminal_id);


--
-- Name: fk_site_customer; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY site
    ADD CONSTRAINT fk_site_customer FOREIGN KEY (customer_id) REFERENCES customer(customer_id);


--
-- Name: fk_site_sitetarification; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY sitetarification
    ADD CONSTRAINT fk_site_sitetarification FOREIGN KEY (site_id) REFERENCES site(site_id);


--
-- Name: fk_site_sitetimeslot; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY sitetimeslot
    ADD CONSTRAINT fk_site_sitetimeslot FOREIGN KEY (site_id) REFERENCES site(site_id);


--
-- Name: fk_staticparam_terminal; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY staticparam
    ADD CONSTRAINT fk_staticparam_terminal FOREIGN KEY (terminal_id) REFERENCES terminal(terminal_id);


--
-- Name: fk_submeter_ctmodel; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY submeter
    ADD CONSTRAINT fk_submeter_ctmodel FOREIGN KEY (ctmodel_id) REFERENCES ctmodel(ctmodel_id);


--
-- Name: fk_submeter_site; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY submeter
    ADD CONSTRAINT fk_submeter_site FOREIGN KEY (site_id) REFERENCES site(site_id);


--
-- Name: fk_submeter_submetermodel; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY submeter
    ADD CONSTRAINT fk_submeter_submetermodel FOREIGN KEY (submodel_id) REFERENCES submetermodel(submodel_id);


--
-- Name: fk_supplier_tarification; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY tarification
    ADD CONSTRAINT fk_supplier_tarification FOREIGN KEY (supplier_id) REFERENCES supplier(supplier_id);


--
-- Name: fk_tarification_season; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY season
    ADD CONSTRAINT fk_tarification_season FOREIGN KEY (tarif_id) REFERENCES tarification(tarif_id);


--
-- Name: fk_tarification_sitetarification; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY sitetarification
    ADD CONSTRAINT fk_tarification_sitetarification FOREIGN KEY (tarif_id) REFERENCES tarification(tarif_id);


--
-- Name: fk_terminal_configparam; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY configparam
    ADD CONSTRAINT fk_terminal_configparam FOREIGN KEY (terminal_id) REFERENCES terminal(terminal_id);


--
-- Name: fk_terminal_ctmodel; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY terminal
    ADD CONSTRAINT fk_terminal_ctmodel FOREIGN KEY (ctmodel_id) REFERENCES ctmodel(ctmodel_id);


--
-- Name: fk_terminal_gateway; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY terminal
    ADD CONSTRAINT fk_terminal_gateway FOREIGN KEY (gateway_id) REFERENCES gateway(gateway_id);


--
-- Name: fk_terminal_machine; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY terminal
    ADD CONSTRAINT fk_terminal_machine FOREIGN KEY (machine_id) REFERENCES machine(machine_id);


--
-- Name: fk_terminal_terminalmodel; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY terminal
    ADD CONSTRAINT fk_terminal_terminalmodel FOREIGN KEY (terminalmodel_id) REFERENCES terminalmodel(terminalmodel_id);


--
-- Name: fk_terminal_timervm; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY timervm
    ADD CONSTRAINT fk_terminal_timervm FOREIGN KEY (terminal_id) REFERENCES terminal(terminal_id);


--
-- Name: fk_timeslot_sitetimeslot; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY sitetimeslot
    ADD CONSTRAINT fk_timeslot_sitetimeslot FOREIGN KEY (timeslot_id) REFERENCES timeslot(timeslot_id);


--
-- Name: fk_timeslot_timeslotinterval; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY timeslotinterval
    ADD CONSTRAINT fk_timeslot_timeslotinterval FOREIGN KEY (timeslot_id) REFERENCES timeslot(timeslot_id);


--
-- Name: fk_tp_timeslot; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY timeslot
    ADD CONSTRAINT fk_tp_timeslot FOREIGN KEY (tp_id) REFERENCES tarificationparam(tp_id);


--
-- Name: gateway-coffret-fk; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY gateway
    ADD CONSTRAINT "gateway-coffret-fk" FOREIGN KEY (coffret_id) REFERENCES coffret(coffret_id);


--
-- Name: gateway_building_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY gateway
    ADD CONSTRAINT gateway_building_id_fkey FOREIGN KEY (building_id) REFERENCES building(building_id);


--
-- Name: gatewaymark-fk; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY gatewaymodel
    ADD CONSTRAINT "gatewaymark-fk" FOREIGN KEY (mark_id) REFERENCES gatewaymark(id);


--
-- Name: groupe_measuregroup_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY device2measuregroup
    ADD CONSTRAINT groupe_measuregroup_fk FOREIGN KEY (group_id) REFERENCES measuregroup(id) ON DELETE CASCADE;


--
-- Name: groupe_measuregroup_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sensor2measuregroup
    ADD CONSTRAINT groupe_measuregroup_fk FOREIGN KEY (group_id) REFERENCES measuregroup(id) ON DELETE CASCADE;


--
-- Name: ig_coffret_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY ig
    ADD CONSTRAINT ig_coffret_id_fkey FOREIGN KEY (coffret_id) REFERENCES coffret(coffret_id);


--
-- Name: igmark-fk; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY igmodel
    ADD CONSTRAINT "igmark-fk" FOREIGN KEY (igmark_id) REFERENCES igmark(id);


--
-- Name: instId; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY comment
    ADD CONSTRAINT "instId" FOREIGN KEY (inst_id) REFERENCES installer(inst_id);


--
-- Name: instId_fk; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY site
    ADD CONSTRAINT "instId_fk" FOREIGN KEY (inst_id) REFERENCES installer(inst_id);


--
-- Name: ismodbus_bridge_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY ismodbus
    ADD CONSTRAINT ismodbus_bridge_id_fkey FOREIGN KEY (bridge_id) REFERENCES bridge(bridge_id);


--
-- Name: ismodbus_ig_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY ismodbus
    ADD CONSTRAINT ismodbus_ig_id_fkey FOREIGN KEY (ig_id) REFERENCES ig(ig_id);


--
-- Name: license_customer_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY license
    ADD CONSTRAINT license_customer_fk FOREIGN KEY (customer_id) REFERENCES customer(customer_id);


--
-- Name: machinealgoparam_machinealgoparam_administrator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY machinealgoparam
    ADD CONSTRAINT machinealgoparam_machinealgoparam_administrator_id_fkey FOREIGN KEY (machinealgoparam_administrator_id) REFERENCES administrator(admin_id);


--
-- Name: machinealgoparam_machinealgoparam_machine_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY machinealgoparam
    ADD CONSTRAINT machinealgoparam_machinealgoparam_machine_id_fkey FOREIGN KEY (machinealgoparam_machine_id) REFERENCES machine(machine_id);


--
-- Name: machinealgoparamvalue_machinealgoparamvalue_machinealgopa_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY machinealgoparamvalue
    ADD CONSTRAINT machinealgoparamvalue_machinealgoparamvalue_machinealgopa_fkey1 FOREIGN KEY (machinealgoparamvalue_machinealgoparamlist_id) REFERENCES machinealgoparamlist(machinealgoparamlist_id);


--
-- Name: machinealgoparamvalue_machinealgoparamvalue_machinealgopar_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY machinealgoparamvalue
    ADD CONSTRAINT machinealgoparamvalue_machinealgoparamvalue_machinealgopar_fkey FOREIGN KEY (machinealgoparamvalue_machinealgoparam_id) REFERENCES machinealgoparam(machinealgoparam_id);


--
-- Name: measurpointrcp_address_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY measurpointrcp
    ADD CONSTRAINT measurpointrcp_address_id_fkey FOREIGN KEY (address_id) REFERENCES addressrcp(address_id);


--
-- Name: menugroup2customer_customer_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY menugroup2customer
    ADD CONSTRAINT menugroup2customer_customer_fk FOREIGN KEY (customer_id) REFERENCES customer(customer_id);


--
-- Name: menugroup2customer_license_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY menugroup2customer
    ADD CONSTRAINT menugroup2customer_license_fk FOREIGN KEY (license_id) REFERENCES license(id);


--
-- Name: menugroup2customer_menu_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY menugroup2customer
    ADD CONSTRAINT menugroup2customer_menu_fk FOREIGN KEY (menu_id) REFERENCES menugroup(id);


--
-- Name: menugroup_parent_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY menugroup
    ADD CONSTRAINT menugroup_parent_fk FOREIGN KEY (parent_id) REFERENCES menugroup(id) ON DELETE CASCADE;


--
-- Name: mesuresrcp_measurpoint_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY mesuresrcp
    ADD CONSTRAINT mesuresrcp_measurpoint_id_fkey FOREIGN KEY (measurpoint_id) REFERENCES measurpointrcp(measurpoint_id);


--
-- Name: modification_timer_history_fk; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY timer_modification_history
    ADD CONSTRAINT modification_timer_history_fk FOREIGN KEY (timer_id) REFERENCES timer(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: powersupply_powersupplymodel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY powersupply
    ADD CONSTRAINT powersupply_powersupplymodel_id_fkey FOREIGN KEY (powersupplymodel_id) REFERENCES powersupplymodel(powersupplymodel_id);


--
-- Name: reverseparam_terminal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY reverseparam
    ADD CONSTRAINT reverseparam_terminal_id_fkey FOREIGN KEY (terminal_id) REFERENCES terminal(terminal_id);


--
-- Name: axelorrole2menugroup_menu_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY axelorrole2menugroup
    ADD CONSTRAINT axelorrole2menugroup_menu_fk FOREIGN KEY (menu_id) REFERENCES menugroup(id);


--
-- Name: axelorrole2menugroup_role_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY axelorrole2menugroup
    ADD CONSTRAINT axelorrole2menugroup_role_fk FOREIGN KEY (role_id) REFERENCES axelorrole(id);


--
-- Name: axelorrole_customer_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY axelorrole
    ADD CONSTRAINT axelorrole_customer_fk FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE;


--
-- Name: axelorrole_site_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY axelorrole
    ADD CONSTRAINT axelorrole_site_fk FOREIGN KEY (site_id) REFERENCES site(site_id) ON DELETE CASCADE;


--
-- Name: axeloruser_customer_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY axeloruser
    ADD CONSTRAINT axeloruser_customer_fk FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE;


--
-- Name: sensor_ismodbus_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY sensor
    ADD CONSTRAINT sensor_ismodbus_id_fkey FOREIGN KEY (ismodbus_id) REFERENCES ismodbus(ismodbus_id);


--
-- Name: site-grappe-fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grappe
    ADD CONSTRAINT "site-grappe-fk" FOREIGN KEY (site_id) REFERENCES site(site_id);


--
-- Name: siteId; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY comment
    ADD CONSTRAINT "siteId" FOREIGN KEY (site_id) REFERENCES site(site_id);


--
-- Name: site_measuregroup_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY measuregroup
    ADD CONSTRAINT site_measuregroup_fk FOREIGN KEY (site_id) REFERENCES site(site_id) ON DELETE CASCADE;


--
-- Name: submeter-coffret-fk; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY submeter
    ADD CONSTRAINT "submeter-coffret-fk" FOREIGN KEY (coffret_id) REFERENCES coffret(coffret_id);


--
-- Name: submeter_measuregroup_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY device2measuregroup
    ADD CONSTRAINT submeter_measuregroup_fk FOREIGN KEY (submeter_id) REFERENCES submeter(submeter_id) ON DELETE CASCADE;


--
-- Name: submetermark-fk; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY submetermodel
    ADD CONSTRAINT "submetermark-fk" FOREIGN KEY (mark_id) REFERENCES submetermark(id);


--
-- Name: submetermodel_submodel_ct_fkey; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY submetermodel
    ADD CONSTRAINT submetermodel_submodel_ct_fkey FOREIGN KEY (submodel_ct) REFERENCES ctmodel(ctmodel_id);


--
-- Name: temporairevaluesrcp_measurpoint_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY temporairevaluesrcp
    ADD CONSTRAINT temporairevaluesrcp_measurpoint_id_fkey FOREIGN KEY (measurpoint_id) REFERENCES measurpointrcp(measurpoint_id);


--
-- Name: terminal-timer-fk; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY timer
    ADD CONSTRAINT "terminal-timer-fk" FOREIGN KEY (terminal_id) REFERENCES terminal(terminal_id) ON DELETE CASCADE;


--
-- Name: terminal_measuregroup_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY device2measuregroup
    ADD CONSTRAINT terminal_measuregroup_fk FOREIGN KEY (terminal_id) REFERENCES terminal(terminal_id) ON DELETE CASCADE;


--
-- Name: terminalmark-fk; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY terminalmodel
    ADD CONSTRAINT "terminalmark-fk" FOREIGN KEY (mark_id) REFERENCES terminalmark(id);


--
-- Name: terminalmodel_terminalmodel_ct_fkey; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY terminalmodel
    ADD CONSTRAINT terminalmodel_terminalmodel_ct_fkey FOREIGN KEY (terminalmodel_ct) REFERENCES ctmodel(ctmodel_id);


--
-- Name: terminalstats_terminal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY terminalstats
    ADD CONSTRAINT terminalstats_terminal_id_fkey FOREIGN KEY (terminal_id) REFERENCES terminal(terminal_id);


--
-- Name: transactionsrcp_measurpoint_idbuyer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY transactionsrcp
    ADD CONSTRAINT transactionsrcp_measurpoint_idbuyer_fkey FOREIGN KEY (measurpoint_idbuyer) REFERENCES measurpointrcp(measurpoint_id);


--
-- Name: transactionsrcp_measurpoint_idseller_fkey; Type: FK CONSTRAINT; Schema: public; Owner: axelor
--

ALTER TABLE ONLY transactionsrcp
    ADD CONSTRAINT transactionsrcp_measurpoint_idseller_fkey FOREIGN KEY (measurpoint_idseller) REFERENCES measurpointrcp(measurpoint_id);


--
-- Name: user2axelorrole_role_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user2axelorrole
    ADD CONSTRAINT user2axelorrole_role_fk FOREIGN KEY (role_id) REFERENCES axelorrole(id);


--
-- Name: user2axelorrole_site_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user2axelorrole
    ADD CONSTRAINT user2axelorrole_site_fk FOREIGN KEY (site_id) REFERENCES site(site_id);


--
-- Name: user2axelorrole_user_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user2axelorrole
    ADD CONSTRAINT user2axelorrole_user_fk FOREIGN KEY (user_id) REFERENCES axeloruser(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: administrator; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE administrator FROM PUBLIC;
REVOKE ALL ON TABLE administrator FROM axelor;
GRANT ALL ON TABLE administrator TO axelor;
GRANT ALL ON TABLE administrator TO root;
GRANT ALL ON TABLE administrator TO postgres;


--
-- Name: algoconfig; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE algoconfig FROM PUBLIC;
REVOKE ALL ON TABLE algoconfig FROM axelor;
GRANT ALL ON TABLE algoconfig TO axelor;
GRANT ALL ON TABLE algoconfig TO root;


--
-- Name: algoparam; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE algoparam FROM PUBLIC;
REVOKE ALL ON TABLE algoparam FROM axelor;
GRANT ALL ON TABLE algoparam TO axelor;
GRANT ALL ON TABLE algoparam TO root;


--
-- Name: armoire; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE armoire FROM PUBLIC;
REVOKE ALL ON TABLE armoire FROM axelor;
GRANT ALL ON TABLE armoire TO axelor;
GRANT ALL ON TABLE armoire TO root;


--
-- Name: bridge; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE bridge FROM PUBLIC;
REVOKE ALL ON TABLE bridge FROM axelor;
GRANT ALL ON TABLE bridge TO axelor;
GRANT ALL ON TABLE bridge TO root;


--
-- Name: bridgemark; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE bridgemark FROM PUBLIC;
REVOKE ALL ON TABLE bridgemark FROM postgres;
GRANT ALL ON TABLE bridgemark TO postgres;
GRANT ALL ON TABLE bridgemark TO axelor;
GRANT ALL ON TABLE bridgemark TO root;


--
-- Name: bridgemodel; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE bridgemodel FROM PUBLIC;
REVOKE ALL ON TABLE bridgemodel FROM axelor;
GRANT ALL ON TABLE bridgemodel TO axelor;
GRANT ALL ON TABLE bridgemodel TO root;


--
-- Name: building; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE building FROM PUBLIC;
REVOKE ALL ON TABLE building FROM axelor;
GRANT ALL ON TABLE building TO axelor;
GRANT ALL ON TABLE building TO root;


--
-- Name: coffret; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE coffret FROM PUBLIC;
REVOKE ALL ON TABLE coffret FROM axelor;
GRANT ALL ON TABLE coffret TO axelor;
GRANT ALL ON TABLE coffret TO root;


--
-- Name: coffretmark; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE coffretmark FROM PUBLIC;
REVOKE ALL ON TABLE coffretmark FROM postgres;
GRANT ALL ON TABLE coffretmark TO postgres;
GRANT ALL ON TABLE coffretmark TO axelor;
GRANT ALL ON TABLE coffretmark TO root;


--
-- Name: coffretmodel; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE coffretmodel FROM PUBLIC;
REVOKE ALL ON TABLE coffretmodel FROM axelor;
GRANT ALL ON TABLE coffretmodel TO axelor;
GRANT ALL ON TABLE coffretmodel TO root;


--
-- Name: comment; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE comment FROM PUBLIC;
REVOKE ALL ON TABLE comment FROM axelor;
GRANT ALL ON TABLE comment TO axelor;
GRANT ALL ON TABLE comment TO root;
GRANT ALL ON TABLE comment TO postgres;


--
-- Name: configparam; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE configparam FROM PUBLIC;
REVOKE ALL ON TABLE configparam FROM axelor;
GRANT ALL ON TABLE configparam TO axelor;
GRANT ALL ON TABLE configparam TO root;
GRANT ALL ON TABLE configparam TO postgres;


--
-- Name: ctmark; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE ctmark FROM PUBLIC;
REVOKE ALL ON TABLE ctmark FROM postgres;
GRANT ALL ON TABLE ctmark TO postgres;
GRANT ALL ON TABLE ctmark TO axelor;
GRANT ALL ON TABLE ctmark TO root;


--
-- Name: ctmodel; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE ctmodel FROM PUBLIC;
REVOKE ALL ON TABLE ctmodel FROM axelor;
GRANT ALL ON TABLE ctmodel TO axelor;
GRANT ALL ON TABLE ctmodel TO root;
GRANT ALL ON TABLE ctmodel TO postgres;


--
-- Name: customer; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE customer FROM PUBLIC;
REVOKE ALL ON TABLE customer FROM axelor;
GRANT ALL ON TABLE customer TO axelor;
GRANT ALL ON TABLE customer TO root;
GRANT ALL ON TABLE customer TO postgres;


--
-- Name: customerorder; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE customerorder FROM PUBLIC;
REVOKE ALL ON TABLE customerorder FROM axelor;
GRANT ALL ON TABLE customerorder TO axelor;
GRANT ALL ON TABLE customerorder TO root;
GRANT ALL ON TABLE customerorder TO postgres;


--
-- Name: device2measuregroup; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE device2measuregroup FROM PUBLIC;
REVOKE ALL ON TABLE device2measuregroup FROM postgres;
GRANT ALL ON TABLE device2measuregroup TO postgres;
GRANT ALL ON TABLE device2measuregroup TO axelor;
GRANT ALL ON TABLE device2measuregroup TO root;


--
-- Name: mesureparam; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE mesureparam FROM PUBLIC;
REVOKE ALL ON TABLE mesureparam FROM axelor;
GRANT ALL ON TABLE mesureparam TO axelor;
GRANT ALL ON TABLE mesureparam TO root;
GRANT ALL ON TABLE mesureparam TO postgres;


--
-- Name: elti; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE elti FROM PUBLIC;
REVOKE ALL ON TABLE elti FROM axelor;
GRANT ALL ON TABLE elti TO axelor;
GRANT ALL ON TABLE elti TO root;


--
-- Name: fabricationorder; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE fabricationorder FROM PUBLIC;
REVOKE ALL ON TABLE fabricationorder FROM postgres;
GRANT ALL ON TABLE fabricationorder TO postgres;
GRANT ALL ON TABLE fabricationorder TO axelor;
GRANT ALL ON TABLE fabricationorder TO root;


--
-- Name: fabricationorder_fabricationorder_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE fabricationorder_fabricationorder_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE fabricationorder_fabricationorder_id_seq FROM postgres;
GRANT ALL ON SEQUENCE fabricationorder_fabricationorder_id_seq TO postgres;
GRANT ALL ON SEQUENCE fabricationorder_fabricationorder_id_seq TO axelor;


--
-- Name: fabricationordervalue; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE fabricationordervalue FROM PUBLIC;
REVOKE ALL ON TABLE fabricationordervalue FROM postgres;
GRANT ALL ON TABLE fabricationordervalue TO postgres;
GRANT ALL ON TABLE fabricationordervalue TO axelor;
GRANT ALL ON TABLE fabricationordervalue TO root;


--
-- Name: facturationref; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE facturationref FROM PUBLIC;
REVOKE ALL ON TABLE facturationref FROM axelor;
GRANT ALL ON TABLE facturationref TO axelor;
GRANT ALL ON TABLE facturationref TO root;


--
-- Name: gateway; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE gateway FROM PUBLIC;
REVOKE ALL ON TABLE gateway FROM axelor;
GRANT ALL ON TABLE gateway TO axelor;
GRANT ALL ON TABLE gateway TO root;
GRANT ALL ON TABLE gateway TO postgres;


--
-- Name: gatewaymark; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE gatewaymark FROM PUBLIC;
REVOKE ALL ON TABLE gatewaymark FROM postgres;
GRANT ALL ON TABLE gatewaymark TO postgres;
GRANT ALL ON TABLE gatewaymark TO axelor;
GRANT ALL ON TABLE gatewaymark TO root;


--
-- Name: gatewaymodel; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE gatewaymodel FROM PUBLIC;
REVOKE ALL ON TABLE gatewaymodel FROM axelor;
GRANT ALL ON TABLE gatewaymodel TO axelor;
GRANT ALL ON TABLE gatewaymodel TO root;
GRANT ALL ON TABLE gatewaymodel TO postgres;


--
-- Name: grappe; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE grappe FROM PUBLIC;
REVOKE ALL ON TABLE grappe FROM postgres;
GRANT ALL ON TABLE grappe TO postgres;
GRANT ALL ON TABLE grappe TO axelor;
GRANT ALL ON TABLE grappe TO root;


--
-- Name: ig; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE ig FROM PUBLIC;
REVOKE ALL ON TABLE ig FROM axelor;
GRANT ALL ON TABLE ig TO axelor;
GRANT ALL ON TABLE ig TO root;


--
-- Name: igmark; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE igmark FROM PUBLIC;
REVOKE ALL ON TABLE igmark FROM postgres;
GRANT ALL ON TABLE igmark TO postgres;
GRANT ALL ON TABLE igmark TO axelor;
GRANT ALL ON TABLE igmark TO root;


--
-- Name: igmodel; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE igmodel FROM PUBLIC;
REVOKE ALL ON TABLE igmodel FROM axelor;
GRANT ALL ON TABLE igmodel TO axelor;
GRANT ALL ON TABLE igmodel TO root;


--
-- Name: installer; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE installer FROM PUBLIC;
REVOKE ALL ON TABLE installer FROM axelor;
GRANT ALL ON TABLE installer TO axelor;
GRANT ALL ON TABLE installer TO root;
GRANT ALL ON TABLE installer TO postgres;


--
-- Name: ismodbus; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE ismodbus FROM PUBLIC;
REVOKE ALL ON TABLE ismodbus FROM axelor;
GRANT ALL ON TABLE ismodbus TO axelor;
GRANT ALL ON TABLE ismodbus TO root;


--
-- Name: ismodbusmodel; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE ismodbusmodel FROM PUBLIC;
REVOKE ALL ON TABLE ismodbusmodel FROM axelor;
GRANT ALL ON TABLE ismodbusmodel TO axelor;
GRANT ALL ON TABLE ismodbusmodel TO root;


--
-- Name: license; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE license FROM PUBLIC;
REVOKE ALL ON TABLE license FROM postgres;
GRANT ALL ON TABLE license TO postgres;
GRANT ALL ON TABLE license TO axelor;
GRANT ALL ON TABLE license TO root;


--
-- Name: machine; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE machine FROM PUBLIC;
REVOKE ALL ON TABLE machine FROM axelor;
GRANT ALL ON TABLE machine TO axelor;
GRANT ALL ON TABLE machine TO root;
GRANT ALL ON TABLE machine TO postgres;


--
-- Name: machinetype; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE machinetype FROM PUBLIC;
REVOKE ALL ON TABLE machinetype FROM axelor;
GRANT ALL ON TABLE machinetype TO axelor;
GRANT ALL ON TABLE machinetype TO root;
GRANT ALL ON TABLE machinetype TO postgres;


--
-- Name: maintenance; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE maintenance FROM PUBLIC;
REVOKE ALL ON TABLE maintenance FROM axelor;
GRANT ALL ON TABLE maintenance TO axelor;
GRANT ALL ON TABLE maintenance TO root;


--
-- Name: measuregroup; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE measuregroup FROM PUBLIC;
REVOKE ALL ON TABLE measuregroup FROM postgres;
GRANT ALL ON TABLE measuregroup TO postgres;
GRANT ALL ON TABLE measuregroup TO axelor;
GRANT ALL ON TABLE measuregroup TO root;


--
-- Name: menugroup; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE menugroup FROM PUBLIC;
REVOKE ALL ON TABLE menugroup FROM postgres;
GRANT ALL ON TABLE menugroup TO postgres;
GRANT ALL ON TABLE menugroup TO axelor;
GRANT ALL ON TABLE menugroup TO root;


--
-- Name: menugroup2customer; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE menugroup2customer FROM PUBLIC;
REVOKE ALL ON TABLE menugroup2customer FROM postgres;
GRANT ALL ON TABLE menugroup2customer TO postgres;
GRANT ALL ON TABLE menugroup2customer TO axelor;
GRANT ALL ON TABLE menugroup2customer TO root;


--
-- Name: orderitem; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE orderitem FROM PUBLIC;
REVOKE ALL ON TABLE orderitem FROM axelor;
GRANT ALL ON TABLE orderitem TO axelor;
GRANT ALL ON TABLE orderitem TO root;
GRANT ALL ON TABLE orderitem TO postgres;


--
-- Name: page; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE page FROM PUBLIC;
REVOKE ALL ON TABLE page FROM axelor;
GRANT ALL ON TABLE page TO axelor;
GRANT ALL ON TABLE page TO root;
GRANT ALL ON TABLE page TO postgres;


--
-- Name: pagecategory; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE pagecategory FROM PUBLIC;
REVOKE ALL ON TABLE pagecategory FROM axelor;
GRANT ALL ON TABLE pagecategory TO axelor;
GRANT ALL ON TABLE pagecategory TO root;
GRANT ALL ON TABLE pagecategory TO postgres;


--
-- Name: partner; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE partner FROM PUBLIC;
REVOKE ALL ON TABLE partner FROM axelor;
GRANT ALL ON TABLE partner TO axelor;
GRANT ALL ON TABLE partner TO root;
GRANT ALL ON TABLE partner TO postgres;


--
-- Name: partnerinstaller; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE partnerinstaller FROM PUBLIC;
REVOKE ALL ON TABLE partnerinstaller FROM axelor;
GRANT ALL ON TABLE partnerinstaller TO axelor;
GRANT ALL ON TABLE partnerinstaller TO root;


--
-- Name: permission; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE permission FROM PUBLIC;
REVOKE ALL ON TABLE permission FROM axelor;
GRANT ALL ON TABLE permission TO axelor;
GRANT ALL ON TABLE permission TO root;
GRANT ALL ON TABLE permission TO postgres;


--
-- Name: powersupply; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE powersupply FROM PUBLIC;
REVOKE ALL ON TABLE powersupply FROM axelor;
GRANT ALL ON TABLE powersupply TO axelor;
GRANT ALL ON TABLE powersupply TO root;


--
-- Name: powersupplymodel; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE powersupplymodel FROM PUBLIC;
REVOKE ALL ON TABLE powersupplymodel FROM axelor;
GRANT ALL ON TABLE powersupplymodel TO axelor;
GRANT ALL ON TABLE powersupplymodel TO root;


--
-- Name: product; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE product FROM PUBLIC;
REVOKE ALL ON TABLE product FROM axelor;
GRANT ALL ON TABLE product TO axelor;
GRANT ALL ON TABLE product TO root;
GRANT ALL ON TABLE product TO postgres;


--
-- Name: rely; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE rely FROM PUBLIC;
REVOKE ALL ON TABLE rely FROM axelor;
GRANT ALL ON TABLE rely TO axelor;
GRANT ALL ON TABLE rely TO root;
GRANT ALL ON TABLE rely TO postgres;


--
-- Name: reportenergy; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE reportenergy FROM PUBLIC;
REVOKE ALL ON TABLE reportenergy FROM axelor;
GRANT ALL ON TABLE reportenergy TO axelor;
GRANT ALL ON TABLE reportenergy TO root;


--
-- Name: reportload; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE reportload FROM PUBLIC;
REVOKE ALL ON TABLE reportload FROM axelor;
GRANT ALL ON TABLE reportload TO axelor;
GRANT ALL ON TABLE reportload TO root;


--
-- Name: reportpower; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE reportpower FROM PUBLIC;
REVOKE ALL ON TABLE reportpower FROM axelor;
GRANT ALL ON TABLE reportpower TO axelor;
GRANT ALL ON TABLE reportpower TO root;


--
-- Name: reversemesureparam; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE reversemesureparam FROM PUBLIC;
REVOKE ALL ON TABLE reversemesureparam FROM postgres;
GRANT ALL ON TABLE reversemesureparam TO postgres;
GRANT ALL ON TABLE reversemesureparam TO axelor;
GRANT ALL ON TABLE reversemesureparam TO root;


--
-- Name: reverseparam; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE reverseparam FROM PUBLIC;
REVOKE ALL ON TABLE reverseparam FROM postgres;
GRANT ALL ON TABLE reverseparam TO postgres;
GRANT ALL ON TABLE reverseparam TO axelor;
GRANT ALL ON TABLE reverseparam TO root;


--
-- Name: roles; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE roles FROM PUBLIC;
REVOKE ALL ON TABLE roles FROM axelor;
GRANT ALL ON TABLE roles TO axelor;
GRANT ALL ON TABLE roles TO root;
GRANT ALL ON TABLE roles TO postgres;


--
-- Name: schema_version; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE schema_version FROM PUBLIC;
REVOKE ALL ON TABLE schema_version FROM postgres;
GRANT ALL ON TABLE schema_version TO postgres;
GRANT ALL ON TABLE schema_version TO axelor;
GRANT ALL ON TABLE schema_version TO root;


--
-- Name: scmesureparam; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE scmesureparam FROM PUBLIC;
REVOKE ALL ON TABLE scmesureparam FROM axelor;
GRANT ALL ON TABLE scmesureparam TO axelor;
GRANT ALL ON TABLE scmesureparam TO root;
GRANT ALL ON TABLE scmesureparam TO postgres;


--
-- Name: season; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE season FROM PUBLIC;
REVOKE ALL ON TABLE season FROM axelor;
GRANT ALL ON TABLE season TO axelor;
GRANT ALL ON TABLE season TO root;


--
-- Name: axelorrole; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE axelorrole FROM PUBLIC;
REVOKE ALL ON TABLE axelorrole FROM postgres;
GRANT ALL ON TABLE axelorrole TO postgres;
GRANT ALL ON TABLE axelorrole TO axelor;
GRANT ALL ON TABLE axelorrole TO root;


--
-- Name: axelorrole2menugroup; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE axelorrole2menugroup FROM PUBLIC;
REVOKE ALL ON TABLE axelorrole2menugroup FROM postgres;
GRANT ALL ON TABLE axelorrole2menugroup TO postgres;
GRANT ALL ON TABLE axelorrole2menugroup TO axelor;
GRANT ALL ON TABLE axelorrole2menugroup TO root;


--
-- Name: axeloruser; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE axeloruser FROM PUBLIC;
REVOKE ALL ON TABLE axeloruser FROM postgres;
GRANT ALL ON TABLE axeloruser TO postgres;
GRANT ALL ON TABLE axeloruser TO axelor;
GRANT ALL ON TABLE axeloruser TO root;


--
-- Name: sensor; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE sensor FROM PUBLIC;
REVOKE ALL ON TABLE sensor FROM axelor;
GRANT ALL ON TABLE sensor TO axelor;
GRANT ALL ON TABLE sensor TO root;


--
-- Name: sensor2measuregroup; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE sensor2measuregroup FROM PUBLIC;
REVOKE ALL ON TABLE sensor2measuregroup FROM postgres;
GRANT ALL ON TABLE sensor2measuregroup TO postgres;
GRANT ALL ON TABLE sensor2measuregroup TO axelor;
GRANT ALL ON TABLE sensor2measuregroup TO root;


--
-- Name: sensormeasurement; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE sensormeasurement FROM PUBLIC;
REVOKE ALL ON TABLE sensormeasurement FROM axelor;
GRANT ALL ON TABLE sensormeasurement TO axelor;
GRANT ALL ON TABLE sensormeasurement TO root;


--
-- Name: sensormodel; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE sensormodel FROM PUBLIC;
REVOKE ALL ON TABLE sensormodel FROM axelor;
GRANT ALL ON TABLE sensormodel TO axelor;
GRANT ALL ON TABLE sensormodel TO root;


--
-- Name: sensorterminal; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE sensorterminal FROM PUBLIC;
REVOKE ALL ON TABLE sensorterminal FROM axelor;
GRANT ALL ON TABLE sensorterminal TO axelor;
GRANT ALL ON TABLE sensorterminal TO root;


--
-- Name: site; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE site FROM PUBLIC;
REVOKE ALL ON TABLE site FROM axelor;
GRANT ALL ON TABLE site TO axelor;
GRANT ALL ON TABLE site TO root;
GRANT ALL ON TABLE site TO postgres;


--
-- Name: sitetarification; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE sitetarification FROM PUBLIC;
REVOKE ALL ON TABLE sitetarification FROM axelor;
GRANT ALL ON TABLE sitetarification TO axelor;
GRANT ALL ON TABLE sitetarification TO root;


--
-- Name: sitetimeslot; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE sitetimeslot FROM PUBLIC;
REVOKE ALL ON TABLE sitetimeslot FROM axelor;
GRANT ALL ON TABLE sitetimeslot TO axelor;
GRANT ALL ON TABLE sitetimeslot TO root;


--
-- Name: staticparam; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE staticparam FROM PUBLIC;
REVOKE ALL ON TABLE staticparam FROM axelor;
GRANT ALL ON TABLE staticparam TO axelor;
GRANT ALL ON TABLE staticparam TO root;
GRANT ALL ON TABLE staticparam TO postgres;


--
-- Name: submeter; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE submeter FROM PUBLIC;
REVOKE ALL ON TABLE submeter FROM axelor;
GRANT ALL ON TABLE submeter TO axelor;
GRANT ALL ON TABLE submeter TO root;
GRANT ALL ON TABLE submeter TO postgres;


--
-- Name: submetermark; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE submetermark FROM PUBLIC;
REVOKE ALL ON TABLE submetermark FROM postgres;
GRANT ALL ON TABLE submetermark TO postgres;
GRANT ALL ON TABLE submetermark TO axelor;
GRANT ALL ON TABLE submetermark TO root;


--
-- Name: submetermodel; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE submetermodel FROM PUBLIC;
REVOKE ALL ON TABLE submetermodel FROM axelor;
GRANT ALL ON TABLE submetermodel TO axelor;
GRANT ALL ON TABLE submetermodel TO root;
GRANT ALL ON TABLE submetermodel TO postgres;


--
-- Name: supplier; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE supplier FROM PUBLIC;
REVOKE ALL ON TABLE supplier FROM axelor;
GRANT ALL ON TABLE supplier TO axelor;
GRANT ALL ON TABLE supplier TO root;


--
-- Name: tarification; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE tarification FROM PUBLIC;
REVOKE ALL ON TABLE tarification FROM axelor;
GRANT ALL ON TABLE tarification TO axelor;
GRANT ALL ON TABLE tarification TO root;


--
-- Name: tarificationparam; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE tarificationparam FROM PUBLIC;
REVOKE ALL ON TABLE tarificationparam FROM axelor;
GRANT ALL ON TABLE tarificationparam TO axelor;
GRANT ALL ON TABLE tarificationparam TO root;


--
-- Name: terminal; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE terminal FROM PUBLIC;
REVOKE ALL ON TABLE terminal FROM axelor;
GRANT ALL ON TABLE terminal TO axelor;
GRANT ALL ON TABLE terminal TO root;
GRANT ALL ON TABLE terminal TO postgres;


--
-- Name: terminalmark; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE terminalmark FROM PUBLIC;
REVOKE ALL ON TABLE terminalmark FROM postgres;
GRANT ALL ON TABLE terminalmark TO postgres;
GRANT ALL ON TABLE terminalmark TO axelor;
GRANT ALL ON TABLE terminalmark TO root;


--
-- Name: terminalmodel; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE terminalmodel FROM PUBLIC;
REVOKE ALL ON TABLE terminalmodel FROM axelor;
GRANT ALL ON TABLE terminalmodel TO axelor;
GRANT ALL ON TABLE terminalmodel TO root;
GRANT ALL ON TABLE terminalmodel TO postgres;


--
-- Name: terminalstats; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE terminalstats FROM PUBLIC;
REVOKE ALL ON TABLE terminalstats FROM axelor;
GRANT ALL ON TABLE terminalstats TO axelor;
GRANT ALL ON TABLE terminalstats TO root;


--
-- Name: timer; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE timer FROM PUBLIC;
REVOKE ALL ON TABLE timer FROM axelor;
GRANT ALL ON TABLE timer TO axelor;
GRANT ALL ON TABLE timer TO root;


--
-- Name: timer_modification_history; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE timer_modification_history FROM PUBLIC;
REVOKE ALL ON TABLE timer_modification_history FROM axelor;
GRANT ALL ON TABLE timer_modification_history TO axelor;
GRANT ALL ON TABLE timer_modification_history TO root;


--
-- Name: timervm; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE timervm FROM PUBLIC;
REVOKE ALL ON TABLE timervm FROM axelor;
GRANT ALL ON TABLE timervm TO axelor;
GRANT ALL ON TABLE timervm TO root;


--
-- Name: timeslot; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE timeslot FROM PUBLIC;
REVOKE ALL ON TABLE timeslot FROM axelor;
GRANT ALL ON TABLE timeslot TO axelor;
GRANT ALL ON TABLE timeslot TO root;


--
-- Name: timeslotinterval; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE timeslotinterval FROM PUBLIC;
REVOKE ALL ON TABLE timeslotinterval FROM axelor;
GRANT ALL ON TABLE timeslotinterval TO axelor;
GRANT ALL ON TABLE timeslotinterval TO root;


--
-- Name: user2axelorrole; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE user2axelorrole FROM PUBLIC;
REVOKE ALL ON TABLE user2axelorrole FROM postgres;
GRANT ALL ON TABLE user2axelorrole TO postgres;
GRANT ALL ON TABLE user2axelorrole TO axelor;
GRANT ALL ON TABLE user2axelorrole TO root;


--
-- Name: vista; Type: ACL; Schema: public; Owner: axelor
--

REVOKE ALL ON TABLE vista FROM PUBLIC;
REVOKE ALL ON TABLE vista FROM axelor;
GRANT ALL ON TABLE vista TO axelor;
GRANT ALL ON TABLE vista TO root;


--
-- PostgreSQL database dump complete
--

