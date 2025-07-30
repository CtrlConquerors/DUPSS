--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

-- Started on 2025-07-30 22:57:34

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE IF EXISTS "DUPSS";
--
-- TOC entry 4977 (class 1262 OID 16773)
-- Name: DUPSS; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "DUPSS" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en';


ALTER DATABASE "DUPSS" OWNER TO postgres;

\connect "DUPSS"

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 217 (class 1259 OID 17441)
-- Name: Appointment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Appointment" (
    "AppointmentId" text NOT NULL,
    "MemberId" text NOT NULL,
    "ConsultantId" text NOT NULL,
    "AppointmentDate" timestamp with time zone NOT NULL,
    "Status" text NOT NULL,
    "Topic" text,
    "Notes" text
);


ALTER TABLE public."Appointment" OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 17446)
-- Name: Assessment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Assessment" (
    "AssessmentId" text NOT NULL,
    "AssessmentType" text NOT NULL,
    "Description" text,
    "Version" text DEFAULT '1.0'::text NOT NULL,
    "Language" text DEFAULT 'eng'::text NOT NULL
);


ALTER TABLE public."Assessment" OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17453)
-- Name: AssessmentAnswer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AssessmentAnswer" (
    "AnswerId" text NOT NULL,
    "QuestionId" text NOT NULL,
    "Answer" text NOT NULL,
    "ScoreValue" integer NOT NULL,
    "ScoreDescription" text,
    "AnswerDetails" text
);


ALTER TABLE public."AssessmentAnswer" OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 17458)
-- Name: AssessmentQuestion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AssessmentQuestion" (
    "QuestionId" text NOT NULL,
    "AssessmentId" text NOT NULL,
    "Question" text NOT NULL,
    "QuestionType" text DEFAULT 'MultipleChoice'::text NOT NULL,
    "Sequence" bigint DEFAULT '0'::bigint NOT NULL,
    CONSTRAINT "AssessmentQuestion_Sequence_check" CHECK (("Sequence" >= 0))
);


ALTER TABLE public."AssessmentQuestion" OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17466)
-- Name: AssessmentResult; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AssessmentResult" (
    "ResultId" text NOT NULL,
    "AssessmentId" text NOT NULL,
    "MemberId" text NOT NULL,
    "TotalScore" integer,
    "Recommendation" text,
    "ScoreDetails" text,
    "CompletedOn" date
);


ALTER TABLE public."AssessmentResult" OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 17471)
-- Name: Blog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Blog" (
    "BlogId" text NOT NULL,
    "StaffId" text NOT NULL,
    "Title" text NOT NULL,
    "Content" text NOT NULL,
    "Status" text NOT NULL,
    "BlogTopicId" text NOT NULL
);


ALTER TABLE public."Blog" OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 17476)
-- Name: BlogTopic; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."BlogTopic" (
    "BlogTopicId" text NOT NULL,
    "BlogTopicName" text NOT NULL
);


ALTER TABLE public."BlogTopic" OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 17481)
-- Name: Campaign; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Campaign" (
    "CampaignId" text NOT NULL,
    "StaffId" text NOT NULL,
    "Title" text NOT NULL,
    "Description" text,
    "StartDate" date NOT NULL,
    "EndDate" date,
    "Status" character varying(50) NOT NULL,
    "Location" text,
    "Introduction" text
);


ALTER TABLE public."Campaign" OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 17486)
-- Name: CampaignRegistrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."CampaignRegistrations" (
    "RegistrationId" text NOT NULL,
    "MemberId" text NOT NULL,
    "CampaignId" text NOT NULL,
    "RegisteredAt" date NOT NULL
);


ALTER TABLE public."CampaignRegistrations" OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 17491)
-- Name: Course; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Course" (
    "CourseId" text NOT NULL,
    "TopicId" text NOT NULL,
    "CourseName" text NOT NULL,
    "CourseType" text NOT NULL,
    "StaffId" text NOT NULL,
    "Description" text,
    "ConsultantId" text NOT NULL
);


ALTER TABLE public."Course" OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 17496)
-- Name: CourseEnroll; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."CourseEnroll" (
    "EnrollId" text NOT NULL,
    "MemberId" text NOT NULL,
    "CourseId" text NOT NULL,
    "Status" text NOT NULL,
    "EnrollDate" date NOT NULL,
    "CompleteDate" date
);


ALTER TABLE public."CourseEnroll" OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 17501)
-- Name: CourseTopic; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."CourseTopic" (
    "TopicId" text NOT NULL,
    "TopicName" text NOT NULL
);


ALTER TABLE public."CourseTopic" OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 17506)
-- Name: Role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Role" (
    "RoleId" text NOT NULL,
    "RoleName" text NOT NULL
);


ALTER TABLE public."Role" OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 17511)
-- Name: User; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."User" (
    "UserId" text NOT NULL,
    "RoleId" text DEFAULT 'ME'::text NOT NULL,
    "Username" text NOT NULL,
    "DoB" date,
    "PhoneNumber" text,
    "Email" text NOT NULL,
    "PasswordHash" text NOT NULL,
    "refreshTokenExpiry" timestamp with time zone,
    "refreshToken" text,
    "PasswordResetToken" text,
    "TokenExpiry" timestamp with time zone
);


ALTER TABLE public."User" OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 17517)
-- Name: __EFMigrationsHistory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL
);


ALTER TABLE public."__EFMigrationsHistory" OWNER TO postgres;

--
-- TOC entry 4957 (class 0 OID 17441)
-- Dependencies: 217
-- Data for Name: Appointment; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Appointment" VALUES ('AP0046', 'c96d8d61-93dd-4637-9f21-a9df16162890', 'f12374fd-8174-4263-9334-e960a2f84e5a', '2025-07-04 17:30:00+07', 'Finished', 'test', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."Appointment" VALUES ('AP0067', 'c6e1b498-7d6d-4da8-9f6a-407ff21e98e4', '3c6146fb-4900-4ee4-ae48-08fc822fb7d9', '2025-07-05 09:00:00+07', 'Missed', 'test', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."Appointment" VALUES ('AP0047', '972d149d-0d02-4a3f-b195-5704592ffda4', '66dc42c6-4f2f-4c2b-9415-e1c56b9bfe55', '2025-07-04 17:30:00+07', 'Cancel', 'test', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."Appointment" VALUES ('AP0065', '972d149d-0d02-4a3f-b195-5704592ffda4', '5481541a-60c6-4699-ac0d-12a968525faa', '2025-07-05 09:00:00+07', 'Missed', 'test', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."Appointment" VALUES ('AP0048', '402d96ef-a9c1-469c-a55f-1b17fb4d79c4', '29e63063-d5fd-4d7a-9ea3-8521bdcd4559', '2025-07-04 17:30:00+07', 'Cancel', 'test', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."Appointment" VALUES ('AP0053', '402d96ef-a9c1-469c-a55f-1b17fb4d79c4', 'f12374fd-8174-4263-9334-e960a2f84e5a', '2025-07-06 09:00:00+07', 'Cancel', 'test', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."Appointment" VALUES ('AP0054', '402d96ef-a9c1-469c-a55f-1b17fb4d79c4', 'f12374fd-8174-4263-9334-e960a2f84e5a', '2025-07-07 17:30:00+07', 'Cancel', 'test', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."Appointment" VALUES ('AP0055', '402d96ef-a9c1-469c-a55f-1b17fb4d79c4', '3c6146fb-4900-4ee4-ae48-08fc822fb7d9', '2025-07-05 17:30:00+07', 'Cancel', 'test', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."Appointment" VALUES ('AP0063', 'c96d8d61-93dd-4637-9f21-a9df16162890', '29e63063-d5fd-4d7a-9ea3-8521bdcd4559', '2025-07-05 09:00:00+07', 'Missed', 'test', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."Appointment" VALUES ('AP0059', '196f3a51-faed-4740-b017-24ec41e43e50', '66dc42c6-4f2f-4c2b-9415-e1c56b9bfe55', '2025-07-04 17:30:00+07', 'Cancel', 'test', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."Appointment" VALUES ('AP0061', 'c96d8d61-93dd-4637-9f21-a9df16162890', '3c6146fb-4900-4ee4-ae48-08fc822fb7d9', '2025-07-05 09:00:00+07', 'Cancel', 'test', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."Appointment" VALUES ('AP0062', 'c96d8d61-93dd-4637-9f21-a9df16162890', 'f12374fd-8174-4263-9334-e960a2f84e5a', '2025-07-05 09:00:00+07', 'Cancel', 'test', 'www...') ON CONFLICT DO NOTHING;
INSERT INTO public."Appointment" VALUES ('AP0056', '402d96ef-a9c1-469c-a55f-1b17fb4d79c4', 'f12374fd-8174-4263-9334-e960a2f84e5a', '2025-07-05 09:45:00+07', 'Cancel', 'test', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."Appointment" VALUES ('AP0068', 'c9ce6277-9851-4d66-9dbe-b3243728d8c6', '29e63063-d5fd-4d7a-9ea3-8521bdcd4559', '2025-07-06 09:00:00+07', 'Cancel', 'test', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."Appointment" VALUES ('AP0064', '402d96ef-a9c1-469c-a55f-1b17fb4d79c4', '66dc42c6-4f2f-4c2b-9415-e1c56b9bfe55', '2025-07-05 09:00:00+07', 'Missed', 'test', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."Appointment" VALUES ('AP0066', '83b95e1e-de81-436b-88c3-482e2a50b218', 'f12374fd-8174-4263-9334-e960a2f84e5a', '2025-07-05 09:00:00+07', 'Missed', 'test', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."Appointment" VALUES ('AP0071', 'c96d8d61-93dd-4637-9f21-a9df16162890', '29e63063-d5fd-4d7a-9ea3-8521bdcd4559', '2025-07-17 17:30:00+07', 'Cancel', 'test', 'https://meet.google.com/arw-ysry-kre') ON CONFLICT DO NOTHING;
INSERT INTO public."Appointment" VALUES ('AP0074', 'c96d8d61-93dd-4637-9f21-a9df16162890', '29e63063-d5fd-4d7a-9ea3-8521bdcd4559', '2025-07-18 18:15:00+07', 'Cancel', 'test', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."Appointment" VALUES ('AP0075', 'c96d8d61-93dd-4637-9f21-a9df16162890', '29e63063-d5fd-4d7a-9ea3-8521bdcd4559', '2025-07-19 09:45:00+07', 'Cancel', 'test', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."Appointment" VALUES ('AP0076', 'c96d8d61-93dd-4637-9f21-a9df16162890', '29e63063-d5fd-4d7a-9ea3-8521bdcd4559', '2025-07-18 18:15:00+07', 'Accepted', 'test', 'google meet ...') ON CONFLICT DO NOTHING;
INSERT INTO public."Appointment" VALUES ('AP0072', '402d96ef-a9c1-469c-a55f-1b17fb4d79c4', '5481541a-60c6-4699-ac0d-12a968525faa', '2025-07-16 18:15:00+07', 'Missed', 'test', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."Appointment" VALUES ('AP0078', '402d96ef-a9c1-469c-a55f-1b17fb4d79c4', '5481541a-60c6-4699-ac0d-12a968525faa', '2025-07-19 09:00:00+07', 'Pending', 'test', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."Appointment" VALUES ('AP0079', 'df8d14c0-f6cc-4c6b-98cd-175b28bc57eb', 'f12374fd-8174-4263-9334-e960a2f84e5a', '2025-07-19 09:45:00+07', 'Cancel', 'test', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."Appointment" VALUES ('AP0080', 'df8d14c0-f6cc-4c6b-98cd-175b28bc57eb', '29e63063-d5fd-4d7a-9ea3-8521bdcd4559', '2025-07-19 09:00:00+07', 'Pending', 'test', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."Appointment" VALUES ('AP0081', '97575acd-bfb2-4647-857b-8762ed15bfc1', '66dc42c6-4f2f-4c2b-9415-e1c56b9bfe55', '2025-07-19 09:45:00+07', 'Pending', 'test', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."Appointment" VALUES ('AP0070', '972d149d-0d02-4a3f-b195-5704592ffda4', '66dc42c6-4f2f-4c2b-9415-e1c56b9bfe55', '2025-07-16 17:30:00+07', 'Missed', 'test', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."Appointment" VALUES ('AP0073', 'c6e1b498-7d6d-4da8-9f6a-407ff21e98e4', '22c6a195-1328-4ac1-b667-d92e068dddb5', '2025-07-17 19:00:00+07', 'Missed', 'qrwer', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."Appointment" VALUES ('AP0069', 'c9ce6277-9851-4d66-9dbe-b3243728d8c6', '3c6146fb-4900-4ee4-ae48-08fc822fb7d9', '2025-07-06 09:00:00+07', 'Missed', 'test', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."Appointment" VALUES ('AP0040', 'df8d14c0-f6cc-4c6b-98cd-175b28bc57eb', '3c6146fb-4900-4ee4-ae48-08fc822fb7d9', '2025-07-05 09:00:00+07', 'Cancel', 'test', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."Appointment" VALUES ('AP0077', 'ef9a96c7-df9a-4509-9700-f651328d9f6e', 'f12374fd-8174-4263-9334-e960a2f84e5a', '2025-07-18 17:30:00+07', 'Expired', 'qrwer', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."Appointment" VALUES ('AP0082', 'c6e1b498-7d6d-4da8-9f6a-407ff21e98e4', '3c6146fb-4900-4ee4-ae48-08fc822fb7d9', '2025-07-24 17:30:00+07', 'Pending', 'dsda', NULL) ON CONFLICT DO NOTHING;


--
-- TOC entry 4958 (class 0 OID 17446)
-- Dependencies: 218
-- Data for Name: Assessment; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Assessment" VALUES ('ASSIST-eng-3.0', 'ASSIST', 'Alcohol, Smoking and Substance Involvement Screening Test', '3.0', 'eng') ON CONFLICT DO NOTHING;
INSERT INTO public."Assessment" VALUES ('CRAFFT-eng-2.1', 'CRAFFT', 'Car, Relax, Alone, Forget, Friends, Trouble Screening', '2.1', 'eng') ON CONFLICT DO NOTHING;


--
-- TOC entry 4959 (class 0 OID 17453)
-- Dependencies: 219
-- Data for Name: AssessmentAnswer; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_TOBACCO_Q1_YES', 'ASSIST-eng-3.0_TOBACCO_Q1', 'Yes', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_TOBACCO_Q1_NO', 'ASSIST-eng-3.0_TOBACCO_Q1', 'No', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_TOBACCO_Q2_NEVER', 'ASSIST-eng-3.0_TOBACCO_Q2', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_TOBACCO_Q2_ONCE_OR_TWICE', 'ASSIST-eng-3.0_TOBACCO_Q2', 'Once or twice', 2, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_TOBACCO_Q2_MONTHLY', 'ASSIST-eng-3.0_TOBACCO_Q2', 'Monthly', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_TOBACCO_Q2_WEEKLY', 'ASSIST-eng-3.0_TOBACCO_Q2', 'Weekly', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_TOBACCO_Q2_DAILY_OR_ALMOST_DAILY', 'ASSIST-eng-3.0_TOBACCO_Q2', 'Daily or almost daily', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_TOBACCO_Q3_NEVER', 'ASSIST-eng-3.0_TOBACCO_Q3', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_TOBACCO_Q3_ONCE_OR_TWICE', 'ASSIST-eng-3.0_TOBACCO_Q3', 'Once or twice', 2, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_TOBACCO_Q3_MONTHLY', 'ASSIST-eng-3.0_TOBACCO_Q3', 'Monthly', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_TOBACCO_Q3_WEEKLY', 'ASSIST-eng-3.0_TOBACCO_Q3', 'Weekly', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_TOBACCO_Q3_DAILY_OR_ALMOST_DAILY', 'ASSIST-eng-3.0_TOBACCO_Q3', 'Daily or almost daily', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_TOBACCO_Q4_NEVER', 'ASSIST-eng-3.0_TOBACCO_Q4', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_TOBACCO_Q4_ONCE_OR_TWICE', 'ASSIST-eng-3.0_TOBACCO_Q4', 'Once or twice', 2, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_TOBACCO_Q4_MONTHLY', 'ASSIST-eng-3.0_TOBACCO_Q4', 'Monthly', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_TOBACCO_Q4_WEEKLY', 'ASSIST-eng-3.0_TOBACCO_Q4', 'Weekly', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_TOBACCO_Q4_DAILY_OR_ALMOST_DAILY', 'ASSIST-eng-3.0_TOBACCO_Q4', 'Daily or almost daily', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_TOBACCO_Q5_NEVER', 'ASSIST-eng-3.0_TOBACCO_Q5', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_TOBACCO_Q5_ONCE_OR_TWICE', 'ASSIST-eng-3.0_TOBACCO_Q5', 'Once or twice', 2, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_TOBACCO_Q5_MONTHLY', 'ASSIST-eng-3.0_TOBACCO_Q5', 'Monthly', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_TOBACCO_Q5_WEEKLY', 'ASSIST-eng-3.0_TOBACCO_Q5', 'Weekly', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_TOBACCO_Q5_DAILY_OR_ALMOST_DAILY', 'ASSIST-eng-3.0_TOBACCO_Q5', 'Daily or almost daily', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_TOBACCO_Q6_YES', 'ASSIST-eng-3.0_TOBACCO_Q6', 'Yes', 7, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_TOBACCO_Q6_NO', 'ASSIST-eng-3.0_TOBACCO_Q6', 'No', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_TOBACCO_Q7_YES', 'ASSIST-eng-3.0_TOBACCO_Q7', 'Yes', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_TOBACCO_Q7_NO', 'ASSIST-eng-3.0_TOBACCO_Q7', 'No', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_TOBACCO_Q8_NEVER', 'ASSIST-eng-3.0_TOBACCO_Q8', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_TOBACCO_Q8_YES_IN_THE_PAST_3_MONTHS', 'ASSIST-eng-3.0_TOBACCO_Q8', 'Yes, in the past 3 months', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_TOBACCO_Q8_YES_BUT_NOT_IN_THE_PAST_3_MONTHS', 'ASSIST-eng-3.0_TOBACCO_Q8', 'Yes, but not in the past 3 months', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_ALCOHOL_Q1_YES', 'ASSIST-eng-3.0_ALCOHOL_Q1', 'Yes', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_ALCOHOL_Q1_NO', 'ASSIST-eng-3.0_ALCOHOL_Q1', 'No', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_ALCOHOL_Q2_NEVER', 'ASSIST-eng-3.0_ALCOHOL_Q2', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_ALCOHOL_Q2_ONCE_OR_TWICE', 'ASSIST-eng-3.0_ALCOHOL_Q2', 'Once or twice', 2, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_ALCOHOL_Q2_MONTHLY', 'ASSIST-eng-3.0_ALCOHOL_Q2', 'Monthly', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_ALCOHOL_Q2_WEEKLY', 'ASSIST-eng-3.0_ALCOHOL_Q2', 'Weekly', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_ALCOHOL_Q2_DAILY_OR_ALMOST_DAILY', 'ASSIST-eng-3.0_ALCOHOL_Q2', 'Daily or almost daily', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_ALCOHOL_Q3_NEVER', 'ASSIST-eng-3.0_ALCOHOL_Q3', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_ALCOHOL_Q3_ONCE_OR_TWICE', 'ASSIST-eng-3.0_ALCOHOL_Q3', 'Once or twice', 2, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_ALCOHOL_Q3_MONTHLY', 'ASSIST-eng-3.0_ALCOHOL_Q3', 'Monthly', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_ALCOHOL_Q3_WEEKLY', 'ASSIST-eng-3.0_ALCOHOL_Q3', 'Weekly', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_ALCOHOL_Q3_DAILY_OR_ALMOST_DAILY', 'ASSIST-eng-3.0_ALCOHOL_Q3', 'Daily or almost daily', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_ALCOHOL_Q4_NEVER', 'ASSIST-eng-3.0_ALCOHOL_Q4', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_ALCOHOL_Q4_ONCE_OR_TWICE', 'ASSIST-eng-3.0_ALCOHOL_Q4', 'Once or twice', 2, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_ALCOHOL_Q4_MONTHLY', 'ASSIST-eng-3.0_ALCOHOL_Q4', 'Monthly', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_ALCOHOL_Q4_WEEKLY', 'ASSIST-eng-3.0_ALCOHOL_Q4', 'Weekly', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_ALCOHOL_Q4_DAILY_OR_ALMOST_DAILY', 'ASSIST-eng-3.0_ALCOHOL_Q4', 'Daily or almost daily', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_ALCOHOL_Q5_NEVER', 'ASSIST-eng-3.0_ALCOHOL_Q5', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_ALCOHOL_Q5_ONCE_OR_TWICE', 'ASSIST-eng-3.0_ALCOHOL_Q5', 'Once or twice', 2, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_ALCOHOL_Q5_MONTHLY', 'ASSIST-eng-3.0_ALCOHOL_Q5', 'Monthly', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_ALCOHOL_Q5_WEEKLY', 'ASSIST-eng-3.0_ALCOHOL_Q5', 'Weekly', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_ALCOHOL_Q5_DAILY_OR_ALMOST_DAILY', 'ASSIST-eng-3.0_ALCOHOL_Q5', 'Daily or almost daily', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_ALCOHOL_Q6_YES', 'ASSIST-eng-3.0_ALCOHOL_Q6', 'Yes', 7, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_ALCOHOL_Q6_NO', 'ASSIST-eng-3.0_ALCOHOL_Q6', 'No', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_ALCOHOL_Q7_YES', 'ASSIST-eng-3.0_ALCOHOL_Q7', 'Yes', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_ALCOHOL_Q7_NO', 'ASSIST-eng-3.0_ALCOHOL_Q7', 'No', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_ALCOHOL_Q8_NEVER', 'ASSIST-eng-3.0_ALCOHOL_Q8', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_ALCOHOL_Q8_YES_IN_THE_PAST_3_MONTHS', 'ASSIST-eng-3.0_ALCOHOL_Q8', 'Yes, in the past 3 months', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_ALCOHOL_Q8_YES_BUT_NOT_IN_THE_PAST_3_MONTHS', 'ASSIST-eng-3.0_ALCOHOL_Q8', 'Yes, but not in the past 3 months', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_CANNABIS_Q1_YES', 'ASSIST-eng-3.0_CANNABIS_Q1', 'Yes', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_CANNABIS_Q1_NO', 'ASSIST-eng-3.0_CANNABIS_Q1', 'No', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_CANNABIS_Q2_NEVER', 'ASSIST-eng-3.0_CANNABIS_Q2', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_CANNABIS_Q2_ONCE_OR_TWICE', 'ASSIST-eng-3.0_CANNABIS_Q2', 'Once or twice', 2, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_CANNABIS_Q2_MONTHLY', 'ASSIST-eng-3.0_CANNABIS_Q2', 'Monthly', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_CANNABIS_Q2_WEEKLY', 'ASSIST-eng-3.0_CANNABIS_Q2', 'Weekly', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_CANNABIS_Q2_DAILY_OR_ALMOST_DAILY', 'ASSIST-eng-3.0_CANNABIS_Q2', 'Daily or almost daily', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_CANNABIS_Q3_NEVER', 'ASSIST-eng-3.0_CANNABIS_Q3', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_CANNABIS_Q3_ONCE_OR_TWICE', 'ASSIST-eng-3.0_CANNABIS_Q3', 'Once or twice', 2, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_CANNABIS_Q3_MONTHLY', 'ASSIST-eng-3.0_CANNABIS_Q3', 'Monthly', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_CANNABIS_Q3_WEEKLY', 'ASSIST-eng-3.0_CANNABIS_Q3', 'Weekly', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_CANNABIS_Q3_DAILY_OR_ALMOST_DAILY', 'ASSIST-eng-3.0_CANNABIS_Q3', 'Daily or almost daily', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_CANNABIS_Q4_NEVER', 'ASSIST-eng-3.0_CANNABIS_Q4', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_CANNABIS_Q4_ONCE_OR_TWICE', 'ASSIST-eng-3.0_CANNABIS_Q4', 'Once or twice', 2, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_CANNABIS_Q4_MONTHLY', 'ASSIST-eng-3.0_CANNABIS_Q4', 'Monthly', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_CANNABIS_Q4_WEEKLY', 'ASSIST-eng-3.0_CANNABIS_Q4', 'Weekly', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_CANNABIS_Q5_ONCE_OR_TWICE', 'ASSIST-eng-3.0_CANNABIS_Q5', 'Once or twice', 2, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_CANNABIS_Q5_WEEKLY', 'ASSIST-eng-3.0_CANNABIS_Q5', 'Weekly', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_CANNABIS_Q6_NO', 'ASSIST-eng-3.0_CANNABIS_Q6', 'No', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_CANNABIS_Q7_YES', 'ASSIST-eng-3.0_CANNABIS_Q7', 'Yes', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_CANNABIS_Q8_YES_IN_THE_PAST_3_MONTHS', 'ASSIST-eng-3.0_CANNABIS_Q8', 'Yes, in the past 3 months', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_COCAINE_Q1_NO', 'ASSIST-eng-3.0_COCAINE_Q1', 'No', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_COCAINE_Q2_NEVER', 'ASSIST-eng-3.0_COCAINE_Q2', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_COCAINE_Q2_MONTHLY', 'ASSIST-eng-3.0_COCAINE_Q2', 'Monthly', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_COCAINE_Q2_DAILY_OR_ALMOST_DAILY', 'ASSIST-eng-3.0_COCAINE_Q2', 'Daily or almost daily', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_COCAINE_Q3_NEVER', 'ASSIST-eng-3.0_COCAINE_Q3', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_COCAINE_Q3_MONTHLY', 'ASSIST-eng-3.0_COCAINE_Q3', 'Monthly', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_COCAINE_Q3_DAILY_OR_ALMOST_DAILY', 'ASSIST-eng-3.0_COCAINE_Q3', 'Daily or almost daily', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_COCAINE_Q4_NEVER', 'ASSIST-eng-3.0_COCAINE_Q4', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_COCAINE_Q4_MONTHLY', 'ASSIST-eng-3.0_COCAINE_Q4', 'Monthly', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_COCAINE_Q4_DAILY_OR_ALMOST_DAILY', 'ASSIST-eng-3.0_COCAINE_Q4', 'Daily or almost daily', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_COCAINE_Q5_NEVER', 'ASSIST-eng-3.0_COCAINE_Q5', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_COCAINE_Q5_MONTHLY', 'ASSIST-eng-3.0_COCAINE_Q5', 'Monthly', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_COCAINE_Q5_DAILY_OR_ALMOST_DAILY', 'ASSIST-eng-3.0_COCAINE_Q5', 'Daily or almost daily', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_COCAINE_Q6_YES', 'ASSIST-eng-3.0_COCAINE_Q6', 'Yes', 7, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_COCAINE_Q7_NO', 'ASSIST-eng-3.0_COCAINE_Q7', 'No', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_COCAINE_Q8_NEVER', 'ASSIST-eng-3.0_COCAINE_Q8', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_COCAINE_Q8_YES_BUT_NOT_IN_THE_PAST_3_MONTHS', 'ASSIST-eng-3.0_COCAINE_Q8', 'Yes, but not in the past 3 months', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_AMPHETAMINES_Q1_YES', 'ASSIST-eng-3.0_AMPHETAMINES_Q1', 'Yes', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_AMPHETAMINES_Q2_ONCE_OR_TWICE', 'ASSIST-eng-3.0_AMPHETAMINES_Q2', 'Once or twice', 2, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_AMPHETAMINES_Q2_WEEKLY', 'ASSIST-eng-3.0_AMPHETAMINES_Q2', 'Weekly', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_AMPHETAMINES_Q3_ONCE_OR_TWICE', 'ASSIST-eng-3.0_AMPHETAMINES_Q3', 'Once or twice', 2, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_AMPHETAMINES_Q3_WEEKLY', 'ASSIST-eng-3.0_AMPHETAMINES_Q3', 'Weekly', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_AMPHETAMINES_Q4_ONCE_OR_TWICE', 'ASSIST-eng-3.0_AMPHETAMINES_Q4', 'Once or twice', 2, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_AMPHETAMINES_Q4_WEEKLY', 'ASSIST-eng-3.0_AMPHETAMINES_Q4', 'Weekly', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_AMPHETAMINES_Q5_ONCE_OR_TWICE', 'ASSIST-eng-3.0_AMPHETAMINES_Q5', 'Once or twice', 2, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_AMPHETAMINES_Q5_WEEKLY', 'ASSIST-eng-3.0_AMPHETAMINES_Q5', 'Weekly', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_AMPHETAMINES_Q6_NO', 'ASSIST-eng-3.0_AMPHETAMINES_Q6', 'No', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_AMPHETAMINES_Q7_YES', 'ASSIST-eng-3.0_AMPHETAMINES_Q7', 'Yes', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_AMPHETAMINES_Q8_YES_IN_THE_PAST_3_MONTHS', 'ASSIST-eng-3.0_AMPHETAMINES_Q8', 'Yes, in the past 3 months', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_INHALANTS_Q1_NO', 'ASSIST-eng-3.0_INHALANTS_Q1', 'No', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_INHALANTS_Q2_NEVER', 'ASSIST-eng-3.0_INHALANTS_Q2', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_INHALANTS_Q2_MONTHLY', 'ASSIST-eng-3.0_INHALANTS_Q2', 'Monthly', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_INHALANTS_Q2_DAILY_OR_ALMOST_DAILY', 'ASSIST-eng-3.0_INHALANTS_Q2', 'Daily or almost daily', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_INHALANTS_Q3_NEVER', 'ASSIST-eng-3.0_INHALANTS_Q3', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_INHALANTS_Q3_MONTHLY', 'ASSIST-eng-3.0_INHALANTS_Q3', 'Monthly', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_INHALANTS_Q3_DAILY_OR_ALMOST_DAILY', 'ASSIST-eng-3.0_INHALANTS_Q3', 'Daily or almost daily', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_INHALANTS_Q4_NEVER', 'ASSIST-eng-3.0_INHALANTS_Q4', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_INHALANTS_Q4_MONTHLY', 'ASSIST-eng-3.0_INHALANTS_Q4', 'Monthly', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_INHALANTS_Q4_DAILY_OR_ALMOST_DAILY', 'ASSIST-eng-3.0_INHALANTS_Q4', 'Daily or almost daily', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_INHALANTS_Q5_NEVER', 'ASSIST-eng-3.0_INHALANTS_Q5', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_INHALANTS_Q5_MONTHLY', 'ASSIST-eng-3.0_INHALANTS_Q5', 'Monthly', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_INHALANTS_Q5_DAILY_OR_ALMOST_DAILY', 'ASSIST-eng-3.0_INHALANTS_Q5', 'Daily or almost daily', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_INHALANTS_Q6_YES', 'ASSIST-eng-3.0_INHALANTS_Q6', 'Yes', 7, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_INHALANTS_Q7_NO', 'ASSIST-eng-3.0_INHALANTS_Q7', 'No', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_INHALANTS_Q8_NEVER', 'ASSIST-eng-3.0_INHALANTS_Q8', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_INHALANTS_Q8_YES_BUT_NOT_IN_THE_PAST_3_MONTHS', 'ASSIST-eng-3.0_INHALANTS_Q8', 'Yes, but not in the past 3 months', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_SEDATIVES_Q1_YES', 'ASSIST-eng-3.0_SEDATIVES_Q1', 'Yes', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_SEDATIVES_Q2_ONCE_OR_TWICE', 'ASSIST-eng-3.0_SEDATIVES_Q2', 'Once or twice', 2, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_SEDATIVES_Q2_WEEKLY', 'ASSIST-eng-3.0_SEDATIVES_Q2', 'Weekly', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_SEDATIVES_Q3_ONCE_OR_TWICE', 'ASSIST-eng-3.0_SEDATIVES_Q3', 'Once or twice', 2, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_SEDATIVES_Q3_WEEKLY', 'ASSIST-eng-3.0_SEDATIVES_Q3', 'Weekly', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_SEDATIVES_Q4_ONCE_OR_TWICE', 'ASSIST-eng-3.0_SEDATIVES_Q4', 'Once or twice', 2, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_SEDATIVES_Q4_WEEKLY', 'ASSIST-eng-3.0_SEDATIVES_Q4', 'Weekly', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_SEDATIVES_Q5_ONCE_OR_TWICE', 'ASSIST-eng-3.0_SEDATIVES_Q5', 'Once or twice', 2, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_SEDATIVES_Q5_WEEKLY', 'ASSIST-eng-3.0_SEDATIVES_Q5', 'Weekly', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_SEDATIVES_Q6_NO', 'ASSIST-eng-3.0_SEDATIVES_Q6', 'No', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_SEDATIVES_Q7_YES', 'ASSIST-eng-3.0_SEDATIVES_Q7', 'Yes', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_SEDATIVES_Q8_YES_IN_THE_PAST_3_MONTHS', 'ASSIST-eng-3.0_SEDATIVES_Q8', 'Yes, in the past 3 months', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_HALLUCINOGENS_Q1_NO', 'ASSIST-eng-3.0_HALLUCINOGENS_Q1', 'No', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_HALLUCINOGENS_Q2_NEVER', 'ASSIST-eng-3.0_HALLUCINOGENS_Q2', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_HALLUCINOGENS_Q2_MONTHLY', 'ASSIST-eng-3.0_HALLUCINOGENS_Q2', 'Monthly', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_HALLUCINOGENS_Q2_DAILY_OR_ALMOST_DAILY', 'ASSIST-eng-3.0_HALLUCINOGENS_Q2', 'Daily or almost daily', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_HALLUCINOGENS_Q3_NEVER', 'ASSIST-eng-3.0_HALLUCINOGENS_Q3', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_HALLUCINOGENS_Q3_MONTHLY', 'ASSIST-eng-3.0_HALLUCINOGENS_Q3', 'Monthly', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_HALLUCINOGENS_Q3_DAILY_OR_ALMOST_DAILY', 'ASSIST-eng-3.0_HALLUCINOGENS_Q3', 'Daily or almost daily', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_HALLUCINOGENS_Q4_NEVER', 'ASSIST-eng-3.0_HALLUCINOGENS_Q4', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_CANNABIS_Q4_DAILY_OR_ALMOST_DAILY', 'ASSIST-eng-3.0_CANNABIS_Q4', 'Daily or almost daily', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_CANNABIS_Q5_NEVER', 'ASSIST-eng-3.0_CANNABIS_Q5', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_CANNABIS_Q5_MONTHLY', 'ASSIST-eng-3.0_CANNABIS_Q5', 'Monthly', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_CANNABIS_Q5_DAILY_OR_ALMOST_DAILY', 'ASSIST-eng-3.0_CANNABIS_Q5', 'Daily or almost daily', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_CANNABIS_Q6_YES', 'ASSIST-eng-3.0_CANNABIS_Q6', 'Yes', 7, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_CANNABIS_Q7_NO', 'ASSIST-eng-3.0_CANNABIS_Q7', 'No', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_CANNABIS_Q8_NEVER', 'ASSIST-eng-3.0_CANNABIS_Q8', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_CANNABIS_Q8_YES_BUT_NOT_IN_THE_PAST_3_MONTHS', 'ASSIST-eng-3.0_CANNABIS_Q8', 'Yes, but not in the past 3 months', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_COCAINE_Q1_YES', 'ASSIST-eng-3.0_COCAINE_Q1', 'Yes', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_COCAINE_Q2_ONCE_OR_TWICE', 'ASSIST-eng-3.0_COCAINE_Q2', 'Once or twice', 2, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_COCAINE_Q2_WEEKLY', 'ASSIST-eng-3.0_COCAINE_Q2', 'Weekly', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_COCAINE_Q3_ONCE_OR_TWICE', 'ASSIST-eng-3.0_COCAINE_Q3', 'Once or twice', 2, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_COCAINE_Q3_WEEKLY', 'ASSIST-eng-3.0_COCAINE_Q3', 'Weekly', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_COCAINE_Q4_ONCE_OR_TWICE', 'ASSIST-eng-3.0_COCAINE_Q4', 'Once or twice', 2, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_COCAINE_Q4_WEEKLY', 'ASSIST-eng-3.0_COCAINE_Q4', 'Weekly', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_COCAINE_Q5_ONCE_OR_TWICE', 'ASSIST-eng-3.0_COCAINE_Q5', 'Once or twice', 2, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_COCAINE_Q5_WEEKLY', 'ASSIST-eng-3.0_COCAINE_Q5', 'Weekly', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_COCAINE_Q6_NO', 'ASSIST-eng-3.0_COCAINE_Q6', 'No', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_COCAINE_Q7_YES', 'ASSIST-eng-3.0_COCAINE_Q7', 'Yes', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_COCAINE_Q8_YES_IN_THE_PAST_3_MONTHS', 'ASSIST-eng-3.0_COCAINE_Q8', 'Yes, in the past 3 months', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_AMPHETAMINES_Q1_NO', 'ASSIST-eng-3.0_AMPHETAMINES_Q1', 'No', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_AMPHETAMINES_Q2_NEVER', 'ASSIST-eng-3.0_AMPHETAMINES_Q2', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_AMPHETAMINES_Q2_MONTHLY', 'ASSIST-eng-3.0_AMPHETAMINES_Q2', 'Monthly', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_AMPHETAMINES_Q2_DAILY_OR_ALMOST_DAILY', 'ASSIST-eng-3.0_AMPHETAMINES_Q2', 'Daily or almost daily', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_AMPHETAMINES_Q3_NEVER', 'ASSIST-eng-3.0_AMPHETAMINES_Q3', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_AMPHETAMINES_Q3_MONTHLY', 'ASSIST-eng-3.0_AMPHETAMINES_Q3', 'Monthly', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_AMPHETAMINES_Q3_DAILY_OR_ALMOST_DAILY', 'ASSIST-eng-3.0_AMPHETAMINES_Q3', 'Daily or almost daily', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_AMPHETAMINES_Q4_NEVER', 'ASSIST-eng-3.0_AMPHETAMINES_Q4', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_AMPHETAMINES_Q4_MONTHLY', 'ASSIST-eng-3.0_AMPHETAMINES_Q4', 'Monthly', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_AMPHETAMINES_Q4_DAILY_OR_ALMOST_DAILY', 'ASSIST-eng-3.0_AMPHETAMINES_Q4', 'Daily or almost daily', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_AMPHETAMINES_Q5_NEVER', 'ASSIST-eng-3.0_AMPHETAMINES_Q5', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_AMPHETAMINES_Q5_MONTHLY', 'ASSIST-eng-3.0_AMPHETAMINES_Q5', 'Monthly', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_AMPHETAMINES_Q5_DAILY_OR_ALMOST_DAILY', 'ASSIST-eng-3.0_AMPHETAMINES_Q5', 'Daily or almost daily', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_AMPHETAMINES_Q6_YES', 'ASSIST-eng-3.0_AMPHETAMINES_Q6', 'Yes', 7, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_AMPHETAMINES_Q7_NO', 'ASSIST-eng-3.0_AMPHETAMINES_Q7', 'No', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_AMPHETAMINES_Q8_NEVER', 'ASSIST-eng-3.0_AMPHETAMINES_Q8', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_AMPHETAMINES_Q8_YES_BUT_NOT_IN_THE_PAST_3_MONTHS', 'ASSIST-eng-3.0_AMPHETAMINES_Q8', 'Yes, but not in the past 3 months', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_INHALANTS_Q1_YES', 'ASSIST-eng-3.0_INHALANTS_Q1', 'Yes', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_INHALANTS_Q2_ONCE_OR_TWICE', 'ASSIST-eng-3.0_INHALANTS_Q2', 'Once or twice', 2, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_INHALANTS_Q2_WEEKLY', 'ASSIST-eng-3.0_INHALANTS_Q2', 'Weekly', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_INHALANTS_Q3_ONCE_OR_TWICE', 'ASSIST-eng-3.0_INHALANTS_Q3', 'Once or twice', 2, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_INHALANTS_Q3_WEEKLY', 'ASSIST-eng-3.0_INHALANTS_Q3', 'Weekly', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_INHALANTS_Q4_ONCE_OR_TWICE', 'ASSIST-eng-3.0_INHALANTS_Q4', 'Once or twice', 2, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_INHALANTS_Q4_WEEKLY', 'ASSIST-eng-3.0_INHALANTS_Q4', 'Weekly', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_INHALANTS_Q5_ONCE_OR_TWICE', 'ASSIST-eng-3.0_INHALANTS_Q5', 'Once or twice', 2, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_INHALANTS_Q5_WEEKLY', 'ASSIST-eng-3.0_INHALANTS_Q5', 'Weekly', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_INHALANTS_Q6_NO', 'ASSIST-eng-3.0_INHALANTS_Q6', 'No', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_INHALANTS_Q7_YES', 'ASSIST-eng-3.0_INHALANTS_Q7', 'Yes', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_INHALANTS_Q8_YES_IN_THE_PAST_3_MONTHS', 'ASSIST-eng-3.0_INHALANTS_Q8', 'Yes, in the past 3 months', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_SEDATIVES_Q1_NO', 'ASSIST-eng-3.0_SEDATIVES_Q1', 'No', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_SEDATIVES_Q2_NEVER', 'ASSIST-eng-3.0_SEDATIVES_Q2', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_SEDATIVES_Q2_MONTHLY', 'ASSIST-eng-3.0_SEDATIVES_Q2', 'Monthly', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_SEDATIVES_Q2_DAILY_OR_ALMOST_DAILY', 'ASSIST-eng-3.0_SEDATIVES_Q2', 'Daily or almost daily', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_SEDATIVES_Q3_NEVER', 'ASSIST-eng-3.0_SEDATIVES_Q3', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_SEDATIVES_Q3_MONTHLY', 'ASSIST-eng-3.0_SEDATIVES_Q3', 'Monthly', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_SEDATIVES_Q3_DAILY_OR_ALMOST_DAILY', 'ASSIST-eng-3.0_SEDATIVES_Q3', 'Daily or almost daily', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_SEDATIVES_Q4_NEVER', 'ASSIST-eng-3.0_SEDATIVES_Q4', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_SEDATIVES_Q4_MONTHLY', 'ASSIST-eng-3.0_SEDATIVES_Q4', 'Monthly', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_SEDATIVES_Q4_DAILY_OR_ALMOST_DAILY', 'ASSIST-eng-3.0_SEDATIVES_Q4', 'Daily or almost daily', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_SEDATIVES_Q5_NEVER', 'ASSIST-eng-3.0_SEDATIVES_Q5', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_SEDATIVES_Q5_MONTHLY', 'ASSIST-eng-3.0_SEDATIVES_Q5', 'Monthly', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_SEDATIVES_Q5_DAILY_OR_ALMOST_DAILY', 'ASSIST-eng-3.0_SEDATIVES_Q5', 'Daily or almost daily', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_SEDATIVES_Q6_YES', 'ASSIST-eng-3.0_SEDATIVES_Q6', 'Yes', 7, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_SEDATIVES_Q7_NO', 'ASSIST-eng-3.0_SEDATIVES_Q7', 'No', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_SEDATIVES_Q8_NEVER', 'ASSIST-eng-3.0_SEDATIVES_Q8', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_SEDATIVES_Q8_YES_BUT_NOT_IN_THE_PAST_3_MONTHS', 'ASSIST-eng-3.0_SEDATIVES_Q8', 'Yes, but not in the past 3 months', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_HALLUCINOGENS_Q1_YES', 'ASSIST-eng-3.0_HALLUCINOGENS_Q1', 'Yes', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_HALLUCINOGENS_Q2_ONCE_OR_TWICE', 'ASSIST-eng-3.0_HALLUCINOGENS_Q2', 'Once or twice', 2, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_HALLUCINOGENS_Q2_WEEKLY', 'ASSIST-eng-3.0_HALLUCINOGENS_Q2', 'Weekly', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_HALLUCINOGENS_Q3_ONCE_OR_TWICE', 'ASSIST-eng-3.0_HALLUCINOGENS_Q3', 'Once or twice', 2, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_HALLUCINOGENS_Q3_WEEKLY', 'ASSIST-eng-3.0_HALLUCINOGENS_Q3', 'Weekly', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_HALLUCINOGENS_Q4_ONCE_OR_TWICE', 'ASSIST-eng-3.0_HALLUCINOGENS_Q4', 'Once or twice', 2, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_HALLUCINOGENS_Q4_WEEKLY', 'ASSIST-eng-3.0_HALLUCINOGENS_Q4', 'Weekly', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_HALLUCINOGENS_Q5_ONCE_OR_TWICE', 'ASSIST-eng-3.0_HALLUCINOGENS_Q5', 'Once or twice', 2, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_HALLUCINOGENS_Q5_WEEKLY', 'ASSIST-eng-3.0_HALLUCINOGENS_Q5', 'Weekly', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_HALLUCINOGENS_Q6_NO', 'ASSIST-eng-3.0_HALLUCINOGENS_Q6', 'No', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_HALLUCINOGENS_Q7_YES', 'ASSIST-eng-3.0_HALLUCINOGENS_Q7', 'Yes', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_HALLUCINOGENS_Q8_YES_IN_THE_PAST_3_MONTHS', 'ASSIST-eng-3.0_HALLUCINOGENS_Q8', 'Yes, in the past 3 months', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OPIOIDS_Q1_NO', 'ASSIST-eng-3.0_OPIOIDS_Q1', 'No', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OPIOIDS_Q2_NEVER', 'ASSIST-eng-3.0_OPIOIDS_Q2', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OPIOIDS_Q2_MONTHLY', 'ASSIST-eng-3.0_OPIOIDS_Q2', 'Monthly', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OPIOIDS_Q2_DAILY_OR_ALMOST_DAILY', 'ASSIST-eng-3.0_OPIOIDS_Q2', 'Daily or almost daily', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OPIOIDS_Q3_NEVER', 'ASSIST-eng-3.0_OPIOIDS_Q3', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OPIOIDS_Q3_MONTHLY', 'ASSIST-eng-3.0_OPIOIDS_Q3', 'Monthly', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OPIOIDS_Q3_DAILY_OR_ALMOST_DAILY', 'ASSIST-eng-3.0_OPIOIDS_Q3', 'Daily or almost daily', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OPIOIDS_Q4_NEVER', 'ASSIST-eng-3.0_OPIOIDS_Q4', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OPIOIDS_Q4_MONTHLY', 'ASSIST-eng-3.0_OPIOIDS_Q4', 'Monthly', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OPIOIDS_Q4_DAILY_OR_ALMOST_DAILY', 'ASSIST-eng-3.0_OPIOIDS_Q4', 'Daily or almost daily', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OPIOIDS_Q5_NEVER', 'ASSIST-eng-3.0_OPIOIDS_Q5', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OPIOIDS_Q5_MONTHLY', 'ASSIST-eng-3.0_OPIOIDS_Q5', 'Monthly', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OPIOIDS_Q5_DAILY_OR_ALMOST_DAILY', 'ASSIST-eng-3.0_OPIOIDS_Q5', 'Daily or almost daily', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OPIOIDS_Q6_YES', 'ASSIST-eng-3.0_OPIOIDS_Q6', 'Yes', 7, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OPIOIDS_Q7_NO', 'ASSIST-eng-3.0_OPIOIDS_Q7', 'No', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OPIOIDS_Q8_NEVER', 'ASSIST-eng-3.0_OPIOIDS_Q8', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OPIOIDS_Q8_YES_BUT_NOT_IN_THE_PAST_3_MONTHS', 'ASSIST-eng-3.0_OPIOIDS_Q8', 'Yes, but not in the past 3 months', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OTHER_Q1_YES', 'ASSIST-eng-3.0_OTHER_Q1', 'Yes', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OTHER_Q2_ONCE_OR_TWICE', 'ASSIST-eng-3.0_OTHER_Q2', 'Once or twice', 2, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OTHER_Q2_WEEKLY', 'ASSIST-eng-3.0_OTHER_Q2', 'Weekly', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OTHER_Q3_ONCE_OR_TWICE', 'ASSIST-eng-3.0_OTHER_Q3', 'Once or twice', 2, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OTHER_Q3_WEEKLY', 'ASSIST-eng-3.0_OTHER_Q3', 'Weekly', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OTHER_Q4_ONCE_OR_TWICE', 'ASSIST-eng-3.0_OTHER_Q4', 'Once or twice', 2, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OTHER_Q4_WEEKLY', 'ASSIST-eng-3.0_OTHER_Q4', 'Weekly', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OTHER_Q5_ONCE_OR_TWICE', 'ASSIST-eng-3.0_OTHER_Q5', 'Once or twice', 2, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OTHER_Q5_WEEKLY', 'ASSIST-eng-3.0_OTHER_Q5', 'Weekly', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OTHER_Q6_NO', 'ASSIST-eng-3.0_OTHER_Q6', 'No', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OTHER_Q7_YES', 'ASSIST-eng-3.0_OTHER_Q7', 'Yes', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OTHER_Q8_YES_IN_THE_PAST_3_MONTHS', 'ASSIST-eng-3.0_OTHER_Q8', 'Yes, in the past 3 months', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('CRAFFT-eng-2.1_Q1_0', 'CRAFFT-eng-2.1_Q1', '0', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('CRAFFT-eng-2.1_Q2_1PLUS', 'CRAFFT-eng-2.1_Q2', '1 or more', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('CRAFFT-eng-2.1_Q3_0', 'CRAFFT-eng-2.1_Q3', '0', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('CRAFFT-eng-2.1_Q4_NO', 'CRAFFT-eng-2.1_Q4', 'No', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('CRAFFT-eng-2.1_Q5_YES', 'CRAFFT-eng-2.1_Q5', 'Yes', 1, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('CRAFFT-eng-2.1_Q6_NO', 'CRAFFT-eng-2.1_Q6', 'No', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('CRAFFT-eng-2.1_Q7_YES', 'CRAFFT-eng-2.1_Q7', 'Yes', 1, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('CRAFFT-eng-2.1_Q8_NO', 'CRAFFT-eng-2.1_Q8', 'No', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('CRAFFT-eng-2.1_Q9_YES', 'CRAFFT-eng-2.1_Q9', 'Yes', 1, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_HALLUCINOGENS_Q4_MONTHLY', 'ASSIST-eng-3.0_HALLUCINOGENS_Q4', 'Monthly', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_HALLUCINOGENS_Q4_DAILY_OR_ALMOST_DAILY', 'ASSIST-eng-3.0_HALLUCINOGENS_Q4', 'Daily or almost daily', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_HALLUCINOGENS_Q5_NEVER', 'ASSIST-eng-3.0_HALLUCINOGENS_Q5', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_HALLUCINOGENS_Q5_MONTHLY', 'ASSIST-eng-3.0_HALLUCINOGENS_Q5', 'Monthly', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_HALLUCINOGENS_Q5_DAILY_OR_ALMOST_DAILY', 'ASSIST-eng-3.0_HALLUCINOGENS_Q5', 'Daily or almost daily', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_HALLUCINOGENS_Q6_YES', 'ASSIST-eng-3.0_HALLUCINOGENS_Q6', 'Yes', 7, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_HALLUCINOGENS_Q7_NO', 'ASSIST-eng-3.0_HALLUCINOGENS_Q7', 'No', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_HALLUCINOGENS_Q8_NEVER', 'ASSIST-eng-3.0_HALLUCINOGENS_Q8', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_HALLUCINOGENS_Q8_YES_BUT_NOT_IN_THE_PAST_3_MONTHS', 'ASSIST-eng-3.0_HALLUCINOGENS_Q8', 'Yes, but not in the past 3 months', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OPIOIDS_Q1_YES', 'ASSIST-eng-3.0_OPIOIDS_Q1', 'Yes', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OPIOIDS_Q2_ONCE_OR_TWICE', 'ASSIST-eng-3.0_OPIOIDS_Q2', 'Once or twice', 2, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OPIOIDS_Q2_WEEKLY', 'ASSIST-eng-3.0_OPIOIDS_Q2', 'Weekly', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OPIOIDS_Q3_ONCE_OR_TWICE', 'ASSIST-eng-3.0_OPIOIDS_Q3', 'Once or twice', 2, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OPIOIDS_Q3_WEEKLY', 'ASSIST-eng-3.0_OPIOIDS_Q3', 'Weekly', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OPIOIDS_Q4_ONCE_OR_TWICE', 'ASSIST-eng-3.0_OPIOIDS_Q4', 'Once or twice', 2, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OPIOIDS_Q4_WEEKLY', 'ASSIST-eng-3.0_OPIOIDS_Q4', 'Weekly', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OPIOIDS_Q5_ONCE_OR_TWICE', 'ASSIST-eng-3.0_OPIOIDS_Q5', 'Once or twice', 2, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OPIOIDS_Q5_WEEKLY', 'ASSIST-eng-3.0_OPIOIDS_Q5', 'Weekly', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OPIOIDS_Q6_NO', 'ASSIST-eng-3.0_OPIOIDS_Q6', 'No', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OPIOIDS_Q7_YES', 'ASSIST-eng-3.0_OPIOIDS_Q7', 'Yes', 4, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OPIOIDS_Q8_YES_IN_THE_PAST_3_MONTHS', 'ASSIST-eng-3.0_OPIOIDS_Q8', 'Yes, in the past 3 months', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OTHER_Q1_NO', 'ASSIST-eng-3.0_OTHER_Q1', 'No', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OTHER_Q2_NEVER', 'ASSIST-eng-3.0_OTHER_Q2', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OTHER_Q2_MONTHLY', 'ASSIST-eng-3.0_OTHER_Q2', 'Monthly', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OTHER_Q2_DAILY_OR_ALMOST_DAILY', 'ASSIST-eng-3.0_OTHER_Q2', 'Daily or almost daily', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OTHER_Q3_NEVER', 'ASSIST-eng-3.0_OTHER_Q3', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OTHER_Q3_MONTHLY', 'ASSIST-eng-3.0_OTHER_Q3', 'Monthly', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OTHER_Q3_DAILY_OR_ALMOST_DAILY', 'ASSIST-eng-3.0_OTHER_Q3', 'Daily or almost daily', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OTHER_Q4_NEVER', 'ASSIST-eng-3.0_OTHER_Q4', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OTHER_Q4_MONTHLY', 'ASSIST-eng-3.0_OTHER_Q4', 'Monthly', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OTHER_Q4_DAILY_OR_ALMOST_DAILY', 'ASSIST-eng-3.0_OTHER_Q4', 'Daily or almost daily', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OTHER_Q5_NEVER', 'ASSIST-eng-3.0_OTHER_Q5', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OTHER_Q5_MONTHLY', 'ASSIST-eng-3.0_OTHER_Q5', 'Monthly', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OTHER_Q5_DAILY_OR_ALMOST_DAILY', 'ASSIST-eng-3.0_OTHER_Q5', 'Daily or almost daily', 6, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OTHER_Q6_YES', 'ASSIST-eng-3.0_OTHER_Q6', 'Yes', 7, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OTHER_Q7_NO', 'ASSIST-eng-3.0_OTHER_Q7', 'No', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OTHER_Q8_NEVER', 'ASSIST-eng-3.0_OTHER_Q8', 'Never', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('ASSIST-eng-3.0_OTHER_Q8_YES_BUT_NOT_IN_THE_PAST_3_MONTHS', 'ASSIST-eng-3.0_OTHER_Q8', 'Yes, but not in the past 3 months', 3, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('CRAFFT-eng-2.1_Q1_1PLUS', 'CRAFFT-eng-2.1_Q1', '1 or more', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('CRAFFT-eng-2.1_Q2_0', 'CRAFFT-eng-2.1_Q2', '0', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('CRAFFT-eng-2.1_Q3_1PLUS', 'CRAFFT-eng-2.1_Q3', '1 or more', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('CRAFFT-eng-2.1_Q4_YES', 'CRAFFT-eng-2.1_Q4', 'Yes', 1, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('CRAFFT-eng-2.1_Q5_NO', 'CRAFFT-eng-2.1_Q5', 'No', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('CRAFFT-eng-2.1_Q6_YES', 'CRAFFT-eng-2.1_Q6', 'Yes', 1, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('CRAFFT-eng-2.1_Q7_NO', 'CRAFFT-eng-2.1_Q7', 'No', 0, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('CRAFFT-eng-2.1_Q8_YES', 'CRAFFT-eng-2.1_Q8', 'Yes', 1, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentAnswer" VALUES ('CRAFFT-eng-2.1_Q9_NO', 'CRAFFT-eng-2.1_Q9', 'No', 0, NULL, NULL) ON CONFLICT DO NOTHING;


--
-- TOC entry 4960 (class 0 OID 17458)
-- Dependencies: 220
-- Data for Name: AssessmentQuestion; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_TOBACCO_Q1', 'ASSIST-eng-3.0', 'In your life, have you ever used tobacco?', 'YesNo', 0) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_TOBACCO_Q7', 'ASSIST-eng-3.0', 'Have you ever tried and failed to control, cut down, or stop using tobacco?', 'YesNo', 6) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_ALCOHOL_Q2', 'ASSIST-eng-3.0', 'In the past 3 months, how often have you used alcohol?', 'MultipleChoice', 9) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_ALCOHOL_Q3', 'ASSIST-eng-3.0', 'In the past 3 months, how often have you had a strong desire or urge to use alcohol?', 'MultipleChoice', 10) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_ALCOHOL_Q4', 'ASSIST-eng-3.0', 'In the past 3 months, how often has alcohol use led to health, social, legal, or financial problems?', 'MultipleChoice', 11) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_ALCOHOL_Q5', 'ASSIST-eng-3.0', 'In the past 3 months, how often have you failed to do what was normally expected of you because of alcohol?', 'MultipleChoice', 12) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_ALCOHOL_Q6', 'ASSIST-eng-3.0', 'Has a friend or relative or anyone else ever expressed concern about your use of alcohol?', 'YesNo', 13) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_ALCOHOL_Q8', 'ASSIST-eng-3.0', 'Have you ever used alcohol by injection?', 'MultipleChoice', 15) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_CANNABIS_Q1', 'ASSIST-eng-3.0', 'In your life, have you ever used cannabis?', 'YesNo', 16) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_CANNABIS_Q7', 'ASSIST-eng-3.0', 'Have you ever tried and failed to control, cut down, or stop using cannabis?', 'YesNo', 22) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_COCAINE_Q2', 'ASSIST-eng-3.0', 'In the past 3 months, how often have you used cocaine?', 'MultipleChoice', 25) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_COCAINE_Q3', 'ASSIST-eng-3.0', 'In the past 3 months, how often have you had a strong desire or urge to use cocaine?', 'MultipleChoice', 26) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_COCAINE_Q4', 'ASSIST-eng-3.0', 'In the past 3 months, how often has cocaine use led to health, social, legal, or financial problems?', 'MultipleChoice', 27) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_COCAINE_Q5', 'ASSIST-eng-3.0', 'In the past 3 months, how often have you failed to do what was normally expected of you because of cocaine?', 'MultipleChoice', 28) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_COCAINE_Q6', 'ASSIST-eng-3.0', 'Has a friend or relative or anyone else ever expressed concern about your use of cocaine?', 'YesNo', 29) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_COCAINE_Q8', 'ASSIST-eng-3.0', 'Have you ever used cocaine by injection?', 'MultipleChoice', 31) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_AMPHETAMINES_Q1', 'ASSIST-eng-3.0', 'In your life, have you ever used amphetamines?', 'YesNo', 32) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_AMPHETAMINES_Q7', 'ASSIST-eng-3.0', 'Have you ever tried and failed to control, cut down, or stop using amphetamines?', 'YesNo', 38) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_INHALANTS_Q2', 'ASSIST-eng-3.0', 'In the past 3 months, how often have you used inhalants?', 'MultipleChoice', 41) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_INHALANTS_Q3', 'ASSIST-eng-3.0', 'In the past 3 months, how often have you had a strong desire or urge to use inhalants?', 'MultipleChoice', 42) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_INHALANTS_Q4', 'ASSIST-eng-3.0', 'In the past 3 months, how often has inhalants use led to health, social, legal, or financial problems?', 'MultipleChoice', 43) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_INHALANTS_Q5', 'ASSIST-eng-3.0', 'In the past 3 months, how often have you failed to do what was normally expected of you because of inhalants?', 'MultipleChoice', 44) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_INHALANTS_Q6', 'ASSIST-eng-3.0', 'Has a friend or relative or anyone else ever expressed concern about your use of inhalants?', 'YesNo', 45) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_INHALANTS_Q8', 'ASSIST-eng-3.0', 'Have you ever used inhalants by injection?', 'MultipleChoice', 47) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_SEDATIVES_Q1', 'ASSIST-eng-3.0', 'In your life, have you ever used sedatives?', 'YesNo', 48) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_SEDATIVES_Q7', 'ASSIST-eng-3.0', 'Have you ever tried and failed to control, cut down, or stop using sedatives?', 'YesNo', 54) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_HALLUCINOGENS_Q2', 'ASSIST-eng-3.0', 'In the past 3 months, how often have you used hallucinogens?', 'MultipleChoice', 57) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_HALLUCINOGENS_Q3', 'ASSIST-eng-3.0', 'In the past 3 months, how often have you had a strong desire or urge to use hallucinogens?', 'MultipleChoice', 58) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_HALLUCINOGENS_Q4', 'ASSIST-eng-3.0', 'In the past 3 months, how often has hallucinogens use led to health, social, legal, or financial problems?', 'MultipleChoice', 59) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_HALLUCINOGENS_Q5', 'ASSIST-eng-3.0', 'In the past 3 months, how often have you failed to do what was normally expected of you because of hallucinogens?', 'MultipleChoice', 60) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_HALLUCINOGENS_Q6', 'ASSIST-eng-3.0', 'Has a friend or relative or anyone else ever expressed concern about your use of hallucinogens?', 'YesNo', 61) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_HALLUCINOGENS_Q8', 'ASSIST-eng-3.0', 'Have you ever used hallucinogens by injection?', 'MultipleChoice', 63) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_OPIOIDS_Q1', 'ASSIST-eng-3.0', 'In your life, have you ever used opioids?', 'YesNo', 64) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_OPIOIDS_Q7', 'ASSIST-eng-3.0', 'Have you ever tried and failed to control, cut down, or stop using opioids?', 'YesNo', 70) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_OTHER_Q2', 'ASSIST-eng-3.0', 'In the past 3 months, how often have you used other?', 'MultipleChoice', 73) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_OTHER_Q3', 'ASSIST-eng-3.0', 'In the past 3 months, how often have you had a strong desire or urge to use other?', 'MultipleChoice', 74) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_OTHER_Q4', 'ASSIST-eng-3.0', 'In the past 3 months, how often has other use led to health, social, legal, or financial problems?', 'MultipleChoice', 75) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_OTHER_Q5', 'ASSIST-eng-3.0', 'In the past 3 months, how often have you failed to do what was normally expected of you because of other?', 'MultipleChoice', 76) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_OTHER_Q6', 'ASSIST-eng-3.0', 'Has a friend or relative or anyone else ever expressed concern about your use of other?', 'YesNo', 77) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_OTHER_Q8', 'ASSIST-eng-3.0', 'Have you ever used other by injection?', 'MultipleChoice', 79) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('CRAFFT-eng-2.1_Q2', 'CRAFFT-eng-2.1', 'During the PAST 12 MONTHS, on how many days did you use any marijuana (cannabis, weed, oil, wax, or hash by smoking, vaping, dabbing, or in edibles) or ''synthetic marijuana'' (like ''K2,'' ''Spice'')? Put ''0'' if none.', 'Numeric', 1) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('CRAFFT-eng-2.1_Q4', 'CRAFFT-eng-2.1', 'Have you ever ridden in a CAR driven by someone (including yourself) who was high or had been using alcohol or drugs?', 'YesNo', 3) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('CRAFFT-eng-2.1_Q6', 'CRAFFT-eng-2.1', 'Do you ever use alcohol or drugs while you are by yourself, ALONE?', 'YesNo', 5) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('CRAFFT-eng-2.1_Q8', 'CRAFFT-eng-2.1', 'Do your family or FRIENDS ever tell you that you should cut down on your drinking or drug use?', 'YesNo', 7) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_TOBACCO_Q2', 'ASSIST-eng-3.0', 'In the past 3 months, how often have you used tobacco?', 'MultipleChoice', 1) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_TOBACCO_Q3', 'ASSIST-eng-3.0', 'In the past 3 months, how often have you had a strong desire or urge to use tobacco?', 'MultipleChoice', 2) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_TOBACCO_Q4', 'ASSIST-eng-3.0', 'In the past 3 months, how often has tobacco use led to health, social, legal, or financial problems?', 'MultipleChoice', 3) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_TOBACCO_Q5', 'ASSIST-eng-3.0', 'In the past 3 months, how often have you failed to do what was normally expected of you because of tobacco?', 'MultipleChoice', 4) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_TOBACCO_Q6', 'ASSIST-eng-3.0', 'Has a friend or relative or anyone else ever expressed concern about your use of tobacco?', 'YesNo', 5) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_TOBACCO_Q8', 'ASSIST-eng-3.0', 'Have you ever used tobacco by injection?', 'MultipleChoice', 7) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_ALCOHOL_Q1', 'ASSIST-eng-3.0', 'In your life, have you ever used alcohol?', 'YesNo', 8) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_ALCOHOL_Q7', 'ASSIST-eng-3.0', 'Have you ever tried and failed to control, cut down, or stop using alcohol?', 'YesNo', 14) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_CANNABIS_Q2', 'ASSIST-eng-3.0', 'In the past 3 months, how often have you used cannabis?', 'MultipleChoice', 17) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_CANNABIS_Q3', 'ASSIST-eng-3.0', 'In the past 3 months, how often have you had a strong desire or urge to use cannabis?', 'MultipleChoice', 18) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_CANNABIS_Q4', 'ASSIST-eng-3.0', 'In the past 3 months, how often has cannabis use led to health, social, legal, or financial problems?', 'MultipleChoice', 19) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_CANNABIS_Q5', 'ASSIST-eng-3.0', 'In the past 3 months, how often have you failed to do what was normally expected of you because of cannabis?', 'MultipleChoice', 20) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_CANNABIS_Q6', 'ASSIST-eng-3.0', 'Has a friend or relative or anyone else ever expressed concern about your use of cannabis?', 'YesNo', 21) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_CANNABIS_Q8', 'ASSIST-eng-3.0', 'Have you ever used cannabis by injection?', 'MultipleChoice', 23) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_COCAINE_Q1', 'ASSIST-eng-3.0', 'In your life, have you ever used cocaine?', 'YesNo', 24) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_COCAINE_Q7', 'ASSIST-eng-3.0', 'Have you ever tried and failed to control, cut down, or stop using cocaine?', 'YesNo', 30) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_AMPHETAMINES_Q2', 'ASSIST-eng-3.0', 'In the past 3 months, how often have you used amphetamines?', 'MultipleChoice', 33) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_AMPHETAMINES_Q3', 'ASSIST-eng-3.0', 'In the past 3 months, how often have you had a strong desire or urge to use amphetamines?', 'MultipleChoice', 34) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_AMPHETAMINES_Q4', 'ASSIST-eng-3.0', 'In the past 3 months, how often has amphetamines use led to health, social, legal, or financial problems?', 'MultipleChoice', 35) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_AMPHETAMINES_Q5', 'ASSIST-eng-3.0', 'In the past 3 months, how often have you failed to do what was normally expected of you because of amphetamines?', 'MultipleChoice', 36) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_AMPHETAMINES_Q6', 'ASSIST-eng-3.0', 'Has a friend or relative or anyone else ever expressed concern about your use of amphetamines?', 'YesNo', 37) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_AMPHETAMINES_Q8', 'ASSIST-eng-3.0', 'Have you ever used amphetamines by injection?', 'MultipleChoice', 39) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_INHALANTS_Q1', 'ASSIST-eng-3.0', 'In your life, have you ever used inhalants?', 'YesNo', 40) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_INHALANTS_Q7', 'ASSIST-eng-3.0', 'Have you ever tried and failed to control, cut down, or stop using inhalants?', 'YesNo', 46) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_SEDATIVES_Q2', 'ASSIST-eng-3.0', 'In the past 3 months, how often have you used sedatives?', 'MultipleChoice', 49) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_SEDATIVES_Q3', 'ASSIST-eng-3.0', 'In the past 3 months, how often have you had a strong desire or urge to use sedatives?', 'MultipleChoice', 50) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_SEDATIVES_Q4', 'ASSIST-eng-3.0', 'In the past 3 months, how often has sedatives use led to health, social, legal, or financial problems?', 'MultipleChoice', 51) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_SEDATIVES_Q5', 'ASSIST-eng-3.0', 'In the past 3 months, how often have you failed to do what was normally expected of you because of sedatives?', 'MultipleChoice', 52) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_SEDATIVES_Q6', 'ASSIST-eng-3.0', 'Has a friend or relative or anyone else ever expressed concern about your use of sedatives?', 'YesNo', 53) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_SEDATIVES_Q8', 'ASSIST-eng-3.0', 'Have you ever used sedatives by injection?', 'MultipleChoice', 55) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_HALLUCINOGENS_Q1', 'ASSIST-eng-3.0', 'In your life, have you ever used hallucinogens?', 'YesNo', 56) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_HALLUCINOGENS_Q7', 'ASSIST-eng-3.0', 'Have you ever tried and failed to control, cut down, or stop using hallucinogens?', 'YesNo', 62) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_OPIOIDS_Q2', 'ASSIST-eng-3.0', 'In the past 3 months, how often have you used opioids?', 'MultipleChoice', 65) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_OPIOIDS_Q3', 'ASSIST-eng-3.0', 'In the past 3 months, how often have you had a strong desire or urge to use opioids?', 'MultipleChoice', 66) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_OPIOIDS_Q4', 'ASSIST-eng-3.0', 'In the past 3 months, how often has opioids use led to health, social, legal, or financial problems?', 'MultipleChoice', 67) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_OPIOIDS_Q5', 'ASSIST-eng-3.0', 'In the past 3 months, how often have you failed to do what was normally expected of you because of opioids?', 'MultipleChoice', 68) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_OPIOIDS_Q6', 'ASSIST-eng-3.0', 'Has a friend or relative or anyone else ever expressed concern about your use of opioids?', 'YesNo', 69) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_OPIOIDS_Q8', 'ASSIST-eng-3.0', 'Have you ever used opioids by injection?', 'MultipleChoice', 71) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_OTHER_Q1', 'ASSIST-eng-3.0', 'In your life, have you ever used other?', 'YesNo', 72) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('ASSIST-eng-3.0_OTHER_Q7', 'ASSIST-eng-3.0', 'Have you ever tried and failed to control, cut down, or stop using other?', 'YesNo', 78) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('CRAFFT-eng-2.1_Q1', 'CRAFFT-eng-2.1', 'During the PAST 12 MONTHS, on how many days did you drink more than a few sips of beer, wine, or any drink containing alcohol? Put ''0'' if none.', 'Numeric', 0) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('CRAFFT-eng-2.1_Q3', 'CRAFFT-eng-2.1', 'During the PAST 12 MONTHS, on how many days did you use anything else to get high (like other illegal drugs, pills, prescription or over-the-counter medications, and things that you sniff, huff, vape, or inject)? Put ''0'' if none.', 'Numeric', 2) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('CRAFFT-eng-2.1_Q5', 'CRAFFT-eng-2.1', 'Do you ever use alcohol or drugs to RELAX, feel better about yourself, or fit in?', 'YesNo', 4) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('CRAFFT-eng-2.1_Q7', 'CRAFFT-eng-2.1', 'Do you ever FORGET things you did while using alcohol or drugs?', 'YesNo', 6) ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentQuestion" VALUES ('CRAFFT-eng-2.1_Q9', 'CRAFFT-eng-2.1', 'Have you ever gotten into TROUBLE while you were using alcohol or drugs?', 'YesNo', 8) ON CONFLICT DO NOTHING;


--
-- TOC entry 4961 (class 0 OID 17466)
-- Dependencies: 221
-- Data for Name: AssessmentResult; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."AssessmentResult" VALUES ('3097ba1c-9b00-4d6e-9872-8e8a2a06d1fa', 'CRAFFT-eng-2.1', 'c6e1b498-7d6d-4da8-9f6a-407ff21e98e4', 4, 'High risk: Significant risky behaviors detected. We strongly recommend enrolling in courses, reading blogs, and scheduling a professional consultation.', 'CRAFFT-eng-2.1_Q1: 0;CRAFFT-eng-2.1_Q2: 1 or more;CRAFFT-eng-2.1_Q3: 0;CRAFFT-eng-2.1_Q4: No;CRAFFT-eng-2.1_Q5: Yes;CRAFFT-eng-2.1_Q6: No;CRAFFT-eng-2.1_Q7: Yes;CRAFFT-eng-2.1_Q8: Yes;CRAFFT-eng-2.1_Q9: Yes', '2025-07-18') ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentResult" VALUES ('c06a15f1-1eec-4bc5-8617-46d73aea49bb', 'ASSIST-eng-3.0', 'c6e1b498-7d6d-4da8-9f6a-407ff21e98e4', 89, 'Moderate risk: Some substance use detected. We recommend enrolling in educational courses and monitoring your usage.', 'Tobacco: No use reported;Alcohol: No use reported;Cannabis: No use reported;Cocaine: Score=18; Q2:Weekly, Q3:Never, Q4:Never, Q5:Weekly, Q6:No, Q7:Yes, Q8:Yes, in the past 3 months;Amphetamines: No use reported;Inhalants: Score=23; Q2:Monthly, Q3:Once or twice, Q4:Weekly, Q5:Weekly, Q6:No, Q7:Yes, Q8:Yes, in the past 3 months;Sedatives: No use reported;Hallucinogens: Score=26; Q2:Monthly, Q3:Weekly, Q4:Daily or almost daily, Q5:Daily or almost daily, Q6:Yes, Q7:No, Q8:Never;Opioids: Score=22; Q2:Monthly, Q3:Weekly, Q4:Weekly, Q5:Weekly, Q6:No, Q7:Yes, Q8:Yes, but not in the past 3 months;Other: No use reported', '2025-07-18') ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentResult" VALUES ('bce5ad37-ea54-4bde-83a1-4905c91d615d', 'CRAFFT-eng-2.1', 'c6e1b498-7d6d-4da8-9f6a-407ff21e98e4', 0, 'No risk: No substance use or high-risk behaviors reported. Continue maintaining a healthy lifestyle.', 'CRAFFT-eng-2.1_Q4: No', '2025-07-18') ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentResult" VALUES ('11c62202-34aa-43e2-a46f-5ea6c443b54c', 'CRAFFT-eng-2.1', 'c6e1b498-7d6d-4da8-9f6a-407ff21e98e4', 0, 'No risk: No substance use or high-risk behaviors reported. Continue maintaining a healthy lifestyle.', 'CRAFFT-eng-2.1_Q4: No', '2025-07-18') ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentResult" VALUES ('66b57bdc-253b-4323-843b-49788da210f1', 'CRAFFT-eng-2.1', 'c6e1b498-7d6d-4da8-9f6a-407ff21e98e4', 0, 'No risk: No substance use or high-risk behaviors reported. Continue maintaining a healthy lifestyle.', 'CRAFFT-eng-2.1_Q4: No', '2025-07-18') ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentResult" VALUES ('459085ef-3c24-4393-926a-da1054d3fdbb', 'CRAFFT-eng-2.1', 'c6e1b498-7d6d-4da8-9f6a-407ff21e98e4', 6, 'High risk: Significant risky behaviors detected. We strongly recommend enrolling in courses, reading blogs, and scheduling a professional consultation.', 'CRAFFT-eng-2.1_Q1: 1 or more;CRAFFT-eng-2.1_Q2: 1 or more;CRAFFT-eng-2.1_Q3: 1 or more;CRAFFT-eng-2.1_Q4: Yes;CRAFFT-eng-2.1_Q5: Yes;CRAFFT-eng-2.1_Q6: Yes;CRAFFT-eng-2.1_Q7: Yes;CRAFFT-eng-2.1_Q8: Yes;CRAFFT-eng-2.1_Q9: Yes', '2025-07-18') ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentResult" VALUES ('d91874e8-e5f4-4e73-b517-6a2ee59cf986', 'CRAFFT-eng-2.1', 'c6e1b498-7d6d-4da8-9f6a-407ff21e98e4', 0, 'No risk: No substance use or high-risk behaviors reported. Continue maintaining a healthy lifestyle.', 'CRAFFT-eng-2.1_Q4: No', '2025-07-18') ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentResult" VALUES ('84522550-d057-41a5-9bbd-ff7373837f7c', 'CRAFFT-eng-2.1', 'c6e1b498-7d6d-4da8-9f6a-407ff21e98e4', 3, 'Moderate risk: Some risky behaviors detected. We recommend enrolling in educational courses and monitoring your behavior.', 'CRAFFT-eng-2.1_Q1: 0;CRAFFT-eng-2.1_Q2: 1 or more;CRAFFT-eng-2.1_Q3: 1 or more;CRAFFT-eng-2.1_Q4: Yes;CRAFFT-eng-2.1_Q5: No;CRAFFT-eng-2.1_Q6: Yes;CRAFFT-eng-2.1_Q7: No;CRAFFT-eng-2.1_Q8: Yes;CRAFFT-eng-2.1_Q9: No', '2025-07-18') ON CONFLICT DO NOTHING;
INSERT INTO public."AssessmentResult" VALUES ('b38213a0-33a4-4065-b128-ebe974e8b52a', 'ASSIST-eng-3.0', 'c6e1b498-7d6d-4da8-9f6a-407ff21e98e4', 0, 'No risk: No substance use reported. Continue maintaining a healthy lifestyle.', 'Tobacco: No use reported;Alcohol: No use reported;Cannabis: No use reported;Cocaine: No use reported;Amphetamines: No use reported;Inhalants: No use reported;Sedatives: No use reported;Hallucinogens: No use reported;Opioids: No use reported;Other: No use reported', '2025-07-23') ON CONFLICT DO NOTHING;


--
-- TOC entry 4962 (class 0 OID 17471)
-- Dependencies: 222
-- Data for Name: Blog; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Blog" VALUES ('B0003', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'The Role of Community in Drug Prevention', '# 🤝 **The Role of Community in Drug Prevention**

> *Beyond personal choices, it is the people around us – friends, family, schools, and neighborhoods – who help protect us from the risk of drug use.*

---

## 🏘 **Why Community Matters**

No one lives in isolation.  
Our decisions, especially when we’re young, are deeply shaped by the people, places, and culture around us.

A strong, caring community can:
- Provide accurate information 🧠
- Offer emotional support 🤍
- Create safe spaces free from negative influence 🛡
- Build positive alternatives to risky behavior 🎨⚽

> 🌱 *Drug prevention isn’t only about saying “no” – it’s about building an environment where “yes” to healthier choices feels natural.*

---

## 🧩 **Building Protective Connections**

When people feel connected, valued, and supported, they’re less likely to seek escape through drugs.

Community plays a role through:
- **Family**: Open conversations, shared meals, trust.
- **Friends**: Encouragement, shared interests, looking out for each other.
- **Schools**: Clubs, sports, arts – safe spaces to belong.
- **Local groups**: Youth centers, volunteer projects, faith communities.

These connections become a safety net in times of stress or temptation.

---

## 🌟 **Positive Role Models**

Seeing people who live drug-free, happy lives makes prevention real – not just words.

- Older students who mentor younger ones 🎓
- Coaches, teachers, and community leaders 🧑‍🏫
- Artists, athletes, volunteers showing healthier paths 🎤🏃‍♂️

> ✨ *Role models don’t have to be perfect; they just have to be present.*

---

## 🛠 **Community Actions That Help**

Communities can reduce risk and strengthen resilience by:
- Organizing workshops and awareness campaigns 📚
- Creating safe spaces for recreation and creativity 🏀🎨
- Providing counseling and support services 🧑‍⚕️
- Encouraging open dialogue, not judgment 🗣

These actions help make healthy choices visible and accessible.

---

## 💬 **Your Part in the Community**

Even as individuals, we can:
- Listen without judging 👂
- Share real information, not myths 📖
- Invite friends to positive activities 🎶
- Speak up when someone is struggling 🫶

> 🌱 *A single kind word, a shared walk, or a conversation can change someone’s path.*

---

## 🌼 **Together, Stronger**

Drug prevention isn’t just about personal strength – it’s about **collective care**.  
When a community works together, the message becomes clearer, the support feels closer, and the path forward becomes safer.

> 🤝 *We’re never alone in this journey – and that makes all the difference.*

---

*✨ Strengthen your connections, support your friends, and help build a healthier, safer community for*
', 'Published', 'BTP0006') ON CONFLICT DO NOTHING;
INSERT INTO public."Blog" VALUES ('B0002', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Building Resilience in Youth to Prevent Drug Use', '# 🛡 **Building Resilience in Youth to Prevent Drug Use**

> *Education isn’t only about teaching facts – it’s about equipping young people with the inner strength to face challenges without turning to harmful choices.*

---

## 🌱 **What Is Resilience?**

Resilience is the ability to bounce back from stress, failure, or difficult situations.  
It doesn’t mean **never** struggling – it means being able to recover, learn, and keep going.

For young people, resilience can be the difference between **turning to drugs** for escape and finding healthier ways to cope.

---

## 📚 **Why Focus on Education?**

Education helps build resilience by:
- Teaching young people about risks and consequences 🧠
- Developing life skills: problem-solving, stress management, communication ✏️
- Creating safe environments where students feel seen and supported 🏫
- Encouraging self-reflection and confidence 🌼

> ✨ *Resilience isn’t taught in one lesson – it grows through everyday learning and experience.*

---

## 🧠 **Skills That Strengthen Resilience**

Schools and youth programs can help young people build:
- **Emotional awareness**: recognizing and expressing feelings.
- **Healthy coping strategies**: exercise, art, talking to someone trusted.
- **Decision-making skills**: weighing consequences before acting.
- **Refusal skills**: confidently saying “no” to peer pressure.
- **Goal-setting**: focusing on positive, meaningful plans for the future.

These skills give youth tools to handle stress without needing harmful escape.

---

## 👫 **The Role of Teachers, Parents & Mentors**

Resilience doesn’t grow in isolation – it’s nurtured by supportive adults who:
- Listen without judgment 👂
- Model healthy ways to cope with stress 💪
- Encourage effort, not just success 🌻
- Create spaces where youth feel valued and included 🤍

> 🌿 *Every kind word and moment of support can plant a seed of resilience.*

---

## ⚖️ **Balancing Challenges and Support**

Young people need opportunities to:
- Try new things
- Make mistakes safely
- Learn to handle setbacks

But they also need:
- Encouragement and guidance
- Emotional safety
- Clear information about risks

Together, challenge and support build the strongest foundation.

---

## 🌟 **A Preventive Power**

Building resilience is powerful prevention:
- Youth feel more in control of their choices
- They can handle peer pressure with confidence
- They’re more likely to seek help instead of substances

> 🛡 *Resilience isn’t a shield that stops all problems – but it makes it easier to keep moving forward without drugs.*

---

## ✨ **Conclusion**

Teaching facts about drug risks is important.  
But teaching young people to **believe in themselves, handle stress, and stay connected** may be even more powerful.

> 🌱 *Let’s build resilience – so every young person feels strong enough to say “no” to drugs and “yes” to a healthier future.*

---

*📚 Invest in skills, nurture confidence, and help youth grow strong from the inside out.*
', 'Published', 'BTP0002') ON CONFLICT DO NOTHING;
INSERT INTO public."Blog" VALUES ('B0008', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Learning Beyond the Classroom', '# 📚 **Learning Beyond the Classroom**

> *True education isn’t limited to grades – it prepares us to live, adapt, and grow.*

---

### 🌱 **Why School Isn''t Everything**

Textbooks give facts, but life demands:
- Adaptability 🔄
- Emotional intelligence ❤️
- Communication and empathy 🗣

> ✨ *Real learning often starts after the bell rings.*

---

### 🛠 **Keep Learning Everywhere**

Outside school walls, you can:
- Volunteer and meet new people 🤝
- Explore cultures, books, and ideas 🌍
- Reflect on daily choices and outcomes ✏️
- Turn mistakes into lessons 📖

> 🌿 *Curiosity makes the world your classroom.*

---

### 🌼 **Why It Matters**

Learning broadly helps you:
- Handle change confidently 💪
- See problems from many angles 🔍
- Stay curious and open-minded 🌱

> 🌟 *Education doesn’t end at graduation – it lasts a lifetime.*

---

### 💡 **Conclusion**

Grades fade. Skills, values, and curiosity stay with you.

> 📚 *Never stop learning, wherever life takes you.*

', 'Published', 'BTP0002') ON CONFLICT DO NOTHING;
INSERT INTO public."Blog" VALUES ('B0006', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Finding Balance: Wellness in a Busy World', '# 🌿 **Finding Balance: Wellness in a Busy World**

> *True wellness isn’t about perfection – it’s about finding balance, even on our busiest days.*

---

### 🌱 **Why Balance Matters**

Modern life rarely pauses. Between work, study, and family, it''s easy to ignore our own health. But wellness is not a luxury – it''s a foundation.

Balance helps us:
- Reduce stress 🧘‍♀️
- Improve sleep 😴
- Feel more present and joyful ✨

> 🌼 *Wellness begins with small, consistent choices – not big, sudden changes.*

---

### 🛠 **Simple Steps Toward Balance**

You don’t have to change your whole routine overnight:
- Pause for deep breaths between tasks 🌬
- Swap one sugary drink for water 💧
- Stretch gently in the morning or evening 🧘‍♂️
- Walk outdoors, even for five minutes 🌳

> ✨ *Tiny habits stack up into real transformation.*

---

### 💡 **Wellness Beyond the Body**

True wellness cares for the mind and emotions:
- Practice gratitude daily 🙏
- Connect with supportive people 🤝
- Accept off-days without guilt 🌿

> 🌱 *Balance means making space for what truly matters.*

---

### 🌼 **Conclusion**

Finding balance won’t stop life’s storms – but it helps us stay steady through them.

> 🌿 *Even on your busiest day, choose one small act of self-care. Your future self will thank you.*

', 'Published', 'BTP0001') ON CONFLICT DO NOTHING;
INSERT INTO public."Blog" VALUES ('B0009', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Teaching Courage: Helping Youth Make Wise Choices', '# 🏫 **Teaching Courage: Helping Youth Make Wise Choices**

> *Knowledge shows what’s risky; courage helps choose what’s right.*

---

### 🌱 **The Power of Courage**

Peer pressure, stress, and fear often push youth toward harmful choices.

Teaching courage helps them:
- Say “no” confidently 🙅‍♀️
- Ask for help when needed 🗣
- Defend their values 🛡

> 🌿 *Courage isn’t the absence of fear – it’s acting wisely despite it.*

---

### 🛠 **Ways to Build Courage**

At home and school:
- Share real stories of hard choices 📖
- Encourage speaking up, even when uncertain 📣
- Reward honesty over perfection 🌼
- Show that mistakes are part of learning 🤍

> ✨ *Safe spaces let courage grow.*

---

### 🌼 **Beyond Classrooms**

Families and communities can:
- Model brave choices themselves 🌱
- Celebrate youth who stand up for others 🌟
- Talk openly about consequences, not just rules 🗣

> 🤝 *Courage thrives when supported by caring adults.*

---

### 💡 **Conclusion**

Teach facts, but also build character.  
Because it’s courage that helps youth act on what they know.

> ✨ *In moments of choice, courage makes the difference.*

', 'Published', 'BTP0002') ON CONFLICT DO NOTHING;
INSERT INTO public."Blog" VALUES ('B0007', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Rest as Resistance: The Power of Slowing Down', '# 🍃 **Rest as Resistance: The Power of Slowing Down**

> *Rest isn’t laziness. It’s how we heal, reflect, and keep going.*

---

### 🌙 **Why We Struggle to Rest**

We’re taught to always do more. But endless productivity leads to:
- Burnout 🛑
- Anxiety 😰
- Lower creativity 🎨

> 🌱 *True strength includes knowing when to pause.*

---

### 🧘‍♀️ **Ways to Rest Intentionally**

Rest can be gentle and still, or active and creative:
- Short walks without your phone 🚶‍♀️
- Listening to calming music 🎶
- Writing thoughts in a journal 📓
- Saying no to extra plans when tired 🙅‍♂️

> ✨ *Rest is giving yourself permission to just be.*

---

### 💭 **Redefining Productivity**

Rest is part of being productive:
- Rested minds solve problems better 🧠
- Calm hearts relate better to others ❤️
- Pauses renew energy and perspective 🌿

> 🌼 *You don’t have to earn rest – you deserve it every day.*

---

### 🌿 **Conclusion**

When you slow down, you don’t fall behind – you step into your strength.

> ✨ *Rest today, so you can rise with purpose tomorrow.*

', 'Published', 'BTP0001') ON CONFLICT DO NOTHING;
INSERT INTO public."Blog" VALUES ('B0010', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Everyday Science: How Research Shapes Our Lives', '# 🔬 **Everyday Science: How Research Shapes Our Lives**

> *Science isn’t locked in labs – it lives in every moment of our day.*

---

### 🌱 **Science You See (and Don’t See)**

From the water you drink 💧 to the medicine you take 💊, research keeps you healthy.  
From weather forecasts ☁️ to safer cars 🚗, science quietly protects and guides us.

> 🌟 *Even the simplest modern comfort often starts with decades of research.*

---

### 🧠 **The Power of Asking “Why?”**

Discovery begins when someone wonders:
- Why does this happen? 🤔
- Can we make it better? 🛠
- What if we tried a new way? 🔄

> 🌿 *Curiosity is the seed; research is how it grows.*

---

### 🔍 **How You Can Be Part of It**

You don’t need to wear a lab coat:
- Read about new findings 📰
- Support science education 🧑‍🏫
- Ask questions and think critically 🧠

> ✨ *Science belongs to everyone willing to keep learning.*

---

### 💡 **Conclusion**

Research is more than data – it’s hope, progress, and possibility.

> 🔬 *Stay curious. Because tomorrow’s breakthroughs start with today’s questions.*

', 'Published', 'BTP0003') ON CONFLICT DO NOTHING;
INSERT INTO public."Blog" VALUES ('B0026', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'The Power of Local Governance', '# 🏛️ **The Power of Local Governance**
> *Local decisions shape daily life. Engage with your community leaders.*
---
### 🌱 **Impact on Your Daily Life**
Local government influences:
- Public safety 🚨
- Education 🏫
- Infrastructure 🛣️
- Community services 🤝
> 🌟 *It''s the closest level of government to the people.*
---
### 🛠 **Ways to Get Involved**
- Attend town hall meetings 🗣️
- Vote in local elections ✅
- Volunteer for community boards 🧑‍🤝‍🧑
- Contact your local representatives 📞
> 🌿 *Your participation strengthens local democracy.*
---
### 💡 **Conclusion**
Be an active citizen. Your local government impacts you directly.
> 🏛️ *Shape your community, one local decision at a time.*
', 'Published', 'BTP0004') ON CONFLICT DO NOTHING;
INSERT INTO public."Blog" VALUES ('B0004', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', ' A Journey of Overcoming Temptation', '# 🌱 **A Journey of Overcoming Temptation**

> *A heartfelt story and reflection on resisting the temptation of drugs,  
> finding strength from within, and building a life of purpose beyond addiction.*

---

## 🌙 **Recognizing the Temptation**

There are moments in life when the shadows feel closer than the light.  
For many young people, the temptation to try **drugs** can come quietly:  
a friend’s invitation at a party, a stressful night that feels too heavy to bear, or simple curiosity mixed with loneliness.  

What begins as _“just once”_ can spiral into something far darker and harder to escape.

The first step is **awareness**.  
Temptation often hides behind smiles, promises of relief, or the idea of fitting in.  
The fear of rejection or the need to belong can make that first offer seem harmless – even necessary.

But deep down, we know:  
> 🧠 **Every choice shapes tomorrow.**  
Recognizing that the urge to experiment isn’t harmless curiosity, but the first step onto a dangerous path, can change everything.

---

## 💪 **Finding Strength Within and Around**

No one can fight alone forever.  
Talking to someone – a trusted friend, a counselor, a family member – can help break the silence that temptation feeds on.  
Support networks don’t just catch us when we fall; they remind us why we **want** to stand back up.

Building resilience also means:
- Getting enough rest 🛌
- Practicing mindfulness 🧘‍♀️
- Joining healthy activities 🏃‍♂️
- Learning to cope with stress without substances ✨

These small habits protect us when temptation knocks.

---

## ✍️ **Rewriting the Story**

Overcoming temptation isn’t about never struggling;  
it’s about **rewriting our response**.

Every time we say _“no,”_ we’re not only refusing harm –  
we’re choosing something better: health, freedom, and a future that belongs to us.

People who’ve walked this journey often discover a powerful truth:  
> 🌟 *The strength they built by overcoming temptation becomes a foundation for helping others.*

They become mentors, volunteers, or simply someone who says:  
> _“I’ve been there. And you don’t have to walk that road.”_

---

## 🎯 **Choosing Purpose Over Escape**

Temptation offers escape; **purpose offers meaning**.  
Whether it’s pursuing education, music, sports, or volunteering, having something to care about beyond ourselves protects us in moments of weakness.

Purpose doesn’t remove temptation –  
but it makes it easier to see why it’s worth resisting.

---

## 🛤 **A Journey, Not a Single Choice**

Overcoming the temptation of drugs isn’t a single heroic act.  
It’s a **journey** – filled with doubt, setbacks, and victories.

Every step away from temptation is a step toward a life defined not by fear or addiction, but by **hope, courage, and freedom**.

If you ever face that moment of choice, remember:  
> 🤝 _You’re not alone._  
And every _“no”_ is also a **“yes”** – to your future, your dreams, and your life.

---

*🌱 Stay strong. Stay hopeful. And keep walking your journey.*
', 'Published', 'BTP0002') ON CONFLICT DO NOTHING;
INSERT INTO public."Blog" VALUES ('B0005', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Beyond the Surface', '# 🌿 **Health & Wellness: Beyond the Surface**

> *True wellness is not just the absence of illness – but the presence of balance, purpose, and inner peace.*

---

## 🌱 **Redefining Health**

When we hear "health," we often think of numbers: weight, blood pressure, calories burned.  
But real health goes deeper.  

It’s about how you feel when you wake up.  
It’s the energy you carry into your day, the way you breathe when stressed, and the love you show to yourself and others.

Health isn’t a destination; it’s a **relationship** – with your body, mind, and spirit.

---

## 🧘‍♂️ **The Pillars of Wellness**

True wellness stands on several pillars, each supporting and balancing the others:

- **Physical well-being**: Nourishing food, regular movement, enough sleep.
- **Mental well-being**: Mindfulness, emotional awareness, managing stress.
- **Social well-being**: Meaningful connections, community, empathy.
- **Purpose and meaning**: Knowing what you wake up for each morning.

It’s not about being perfect in each area –  
> 🌼 *It’s about noticing where we’re out of balance and gently coming back.*

---

## ☕ **Small Habits, Big Changes**

Wellness isn’t built overnight.  
It’s built from small, daily choices that become part of who we are:

- Choosing water instead of soda 💧
- Taking a short walk after lunch 🚶‍♀️
- Journaling your thoughts before bed 📓
- Saying *no* when you’re overwhelmed 🙅‍♂️
- Practicing gratitude each morning 🌅

These moments may seem small, but over time, they transform your life.

---

## 💡 **Listening to Your Body and Mind**

Your body speaks in whispers: fatigue, tension, restlessness.  
', 'Published', 'BTP0001') ON CONFLICT DO NOTHING;
INSERT INTO public."Blog" VALUES ('B0001', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Understanding the Risks of Drug Use', '# 📚 **Understanding the Risks of Drug Use**

> *Education is the first step to prevention. Knowing the risks helps us make informed, healthier choices.*

---

## 🧠 **Why Understanding Matters**

Many young people hear "drugs are dangerous" – but without knowing *why* or *how*.  
Real education isn’t about fear; it’s about **understanding the facts**, so we can see beyond myths and peer pressure.

When we truly understand the risks, we can:
- Recognize early warning signs 🚨
- Support friends who might be struggling 🤝
- Make choices that protect our health and future 🌱

---

## ⚠️ **Health Risks You Should Know**

Drug use can seriously harm both **body and mind** – and the risks often appear faster than expected:

- **Brain health**: Impaired memory, learning difficulties, poor decision-making.
- **Physical health**: Heart problems, liver damage, weakened immune system.
- **Mental health**: Anxiety, depression, paranoia, addiction.
- **Accidents & injury**: Reduced coordination and judgment increase the risk of accidents.

> 🧬 *Some effects can last a lifetime – even after you stop using.*

---

## 💭 **Emotional and Social Consequences**

Drug use doesn’t just harm your body – it can also change your life in other ways:

- Damaged relationships with family and friends 💔
- Trouble at school or work 📉
- Financial strain and legal consequences ⚖️
- Loss of trust and self-esteem 🪞

These consequences often start quietly – missing class, mood swings, isolation – and grow over time.

---

## 🛡 **Building Knowledge as Protection**

Learning about the risks isn’t about scaring you;  
it’s about **empowering you** to:

- Make healthier choices ✅
- Speak up when you see risky behavior 🗣
- Find help early if you or someone you know is struggling 🙏

Remember:
> 🌟 *The earlier you act, the easier it is to change direction.*

---

## 🌱 **Prevention Through Education**

Schools, families, and communities all play a part in prevention:
- Honest conversations, not just rules.
- Programs that build skills: stress management, refusal skills, self-confidence.
- Sharing real stories and real consequences.

Together, education creates a safety net – helping each person make choices that protect their future.

---

## 🛤 **Moving Forward**

Drug use carries real risks – to your health, your mind, and your future.  
But knowledge gives you power. Power to choose, to support others, and to live fully.

> 📚 *Understand the risks. Protect your journey. And remember: you always have a choice.*

---

*✨ Stay informed, stay aware, and help build a safer, healthier community.*
', 'Published', 'BTP0002') ON CONFLICT DO NOTHING;
INSERT INTO public."Blog" VALUES ('B0011', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Why Curiosity Drives Discovery', '# 🧪 **Why Curiosity Drives Discovery**

> *At the heart of every scientific breakthrough is a simple question: “What if…?”*

---

### 🌱 **Curiosity Sparks Progress**

Think of every invention you use daily:
- Electricity 💡
- Phones 📱
- Vaccines 💉

They began because someone dared to ask why things work – or why they don’t.

> 🌟 *Discovery starts when we challenge what we think we know.*

---

### 🛠 **Turning Questions Into Research**

Scientists:
- Observe carefully 🔍
- Form hypotheses ✏️
- Test, fail, and test again 🔄

> 🌿 *Failure isn’t an end – it’s part of finding truth.*

---

### 🌼 **Beyond the Lab**

You, too, can think like a scientist:
- Stay curious about everyday things 🤔
- Research answers, not rumors 🧠
- Share knowledge responsibly 🗣

> ✨ *Critical thinking makes us wiser, not just smarter.*

---

### 💡 **Conclusion**

Curiosity turns ideas into impact.  
Keep asking, keep exploring, and keep wondering.

> 🧪 *Discovery belongs to the curious heart.*

', 'Published', 'BTP0003') ON CONFLICT DO NOTHING;
INSERT INTO public."Blog" VALUES ('B0012', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'The Role of Policy in Building Healthier Communities', '# ⚖️ **The Role of Policy in Building Healthier Communities**

> *Good intentions need strong policies to become real change.*

---

### 🌱 **Why Policy Matters**

Education and awareness matter – but laws and policies:
- Fund prevention programs 💰
- Limit harmful products 🚭
- Support treatment and recovery 🤝

> 🌿 *Without policy, progress stays small and scattered.*

---

### 🛠 **Examples of Policy at Work**

- Age limits for alcohol and tobacco 🚫
- School-based prevention programs 📚
- Community health funding 🏥

> ✨ *Behind each rule is a goal: to protect lives.*

---

### 🌼 **The Power of Advocacy**

Anyone can help shape policy by:
- Joining campaigns 🏙
- Sharing stories 📖
- Talking to local leaders 🗣

> 🤝 *Voices together become harder to ignore.*

---

### 💡 **Conclusion**

Policy isn’t politics – it’s protection.  
Advocacy turns shared values into safer communities.

> ⚖️ *Support policies that protect health and hope.*

', 'Published', 'BTP0004') ON CONFLICT DO NOTHING;
INSERT INTO public."Blog" VALUES ('B0013', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Speak Up: Your Voice Shapes Change', '# 🗣 **Speak Up: Your Voice Shapes Change**

> *Change often starts with someone who cares enough to speak.*

---

### 🌱 **What Is Advocacy?**

Advocacy means:
- Raising awareness 🧠
- Influencing decisions 🏛
- Supporting those affected 🤍

> 🌟 *You don’t need to be famous to make an impact.*

---

### 🛠 **Ways to Advocate**

- Share facts on social media 📲
- Join local workshops or town halls 🏫
- Write letters or sign petitions ✍️
- Volunteer in community projects 🤝

> 🌿 *Every action adds strength to the cause.*

---

### 🌼 **Why It Matters**

When people speak up:
- Policies improve ⚖️
- Resources reach more people 💰
- Stigma starts to fade 🛡

> ✨ *Silence keeps problems hidden; voices bring them to light.*

---

### 💡 **Conclusion**

Your words can spark change.  
Use them bravely, kindly, and often.

> 🗣 *Together, our voices build a better tomorrow.*

', 'Published', 'BTP0004') ON CONFLICT DO NOTHING;
INSERT INTO public."Blog" VALUES ('B0014', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Why Awareness Campaigns Matter', '# 🎉 **Why Awareness Campaigns Matter**

> *You can’t prevent what people don’t understand.*

---

### 🌱 **The Purpose of Campaigns**

Campaigns:
- Share real facts 📊
- Challenge myths and stigma 🛡
- Connect people to help 📞

> 🌟 *Awareness makes prevention possible.*

---

### 🛠 **What Makes a Campaign Effective**

- Clear message 📝
- True stories 📖
- Creative, engaging formats 🎨

> 🌿 *People remember what makes them feel, not just what they see.*

---

### 🌼 **Your Role**

- Share campaigns you trust 🗣
- Start conversations with friends 🧡
- Volunteer in local initiatives 🤝

> ✨ *One share, one talk, one action can change a life.*

---

### 💡 **Conclusion**

Campaigns don’t end with posters – they live through us.

> 🎉 *Spread awareness. It starts with you.*

', 'Published', 'BTP0005') ON CONFLICT DO NOTHING;
INSERT INTO public."Blog" VALUES ('B0015', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Community Events: More Than Just Gatherings', '# 📆 **Community Events: More Than Just Gatherings**

> *Events bring people together to learn, heal, and act.*

---

### 🌱 **What Events Offer**

- Education and workshops 📚
- Spaces to share stories 🤍
- Inspiration to get involved ✨

> 🌿 *They turn strangers into allies.*

---

### 🛠 **Different Types of Events**

- Fundraising walks 🚶‍♀️
- School talks 🏫
- Art exhibitions and concerts 🎶

Each brings awareness to new audiences.

---

### 🌼 **Why Show Up Matters**

Your presence:
- Encourages organizers 🌟
- Shows support to affected people 🤝
- Builds a stronger, connected community 🏘

> ✨ *Together, we’re louder and braver.*

---

### 💡 **Conclusion**

Events aren’t just days on a calendar – they’re sparks for change.

> 📆 *Show up. Share hope. Strengthen community.*

', 'Published', 'BTP0005') ON CONFLICT DO NOTHING;
INSERT INTO public."Blog" VALUES ('B0016', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Friendship as a Protective Factor', '# 🤝 **Friendship as a Protective Factor**

> *Good friends don’t just make life happier – they help keep us safer.*

---

### 🌱 **How Friends Protect**

Friends can:
- Offer honest advice 🗣
- Distract from harmful temptations 🎮
- Encourage healthier choices 🏃‍♂️

> 🌿 *True friendship cares about your well-being, not just your company.*

---

### 🛠 **Building Strong Friendships**

- Be open about struggles 🤍
- Respect boundaries ✨
- Choose friends who lift you up 🌼

> 🌟 *It’s quality, not quantity, that matters.*

---

### 🌼 **Beyond Fun**

Friendships also help:
- Reduce loneliness 🧡
- Boost resilience during stress 💪
- Make “no” to risky offers easier 🙅‍♀️

> ✨ *Together, we stay stronger.*

---

### 💡 **Conclusion**

Nurture friendships that bring safety, trust, and kindness.

> 🤝 *Because friends can be your best defense against harm.*

', 'Published', 'BTP0006') ON CONFLICT DO NOTHING;
INSERT INTO public."Blog" VALUES ('B0017', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'The Power of Positive Thinking', '# ✨ **The Power of Positive Thinking**
> *Your mindset shapes your reality. Cultivate optimism for a brighter life.*
---
### 🌱 **Shifting Your Perspective**
Positive thinking isn''t about ignoring problems, but approaching them with hope. It helps:
- Reduce stress 🧘‍♀️
- Improve resilience 💪
- Boost overall happiness  
> 🌟 *A positive mind sees opportunities where others see obstacles.*
---
### 🛠 **Daily Practices for Positivity**
- Practice gratitude daily 🙏
- Surround yourself with positive people 🤝
- Challenge negative thoughts 🧠
- Celebrate small wins 🎉
> 🌿 *Consistency builds a positive mindset.*
---
### 💡 **Conclusion**
Positive thinking is a powerful tool for well-being.
> ✨ *Choose optimism, and transform your world.*
', 'Published', 'BTP0001') ON CONFLICT DO NOTHING;
INSERT INTO public."Blog" VALUES ('B0018', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Understanding the Teenage Brain', '# 🧠 **Understanding the Teenage Brain**
> *The adolescent brain is a dynamic landscape of growth and change.*
---
### 🌱 **A Period of Rapid Development**
Teenage years involve significant brain restructuring, impacting:
- Decision-making 🤔
- Emotional regulation ❤️
- Risk assessment 🚧
> 🌟 *Understanding these changes helps foster empathy and support.*
---
### 🛠 **Supporting Healthy Brain Development**
- Encourage healthy sleep habits 😴
- Promote stress management techniques 🧘‍♀️
- Foster positive social connections 🤝
- Provide opportunities for new learning experiences 📚
> 🌿 *Nurturing the teenage brain leads to healthier adults.*
---
### 💡 **Conclusion**
Embrace the unique journey of adolescence with knowledge and compassion.
> 🧠 *Support their growth, and empower their future.*
', 'Published', 'BTP0002') ON CONFLICT DO NOTHING;
INSERT INTO public."Blog" VALUES ('B0019', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'The Future of Renewable Energy', '# ☀️ **The Future of Renewable Energy**
> *Harnessing nature''s power for a sustainable tomorrow.*
---
### 🌱 **Why Renewables Matter**
Renewable energy sources are crucial for:
- Combating climate change 🌍
- Reducing pollution 💨
- Creating sustainable economies 💰
> 🌟 *The shift to clean energy is essential for our planet''s health.*
---
### 🛠 **Innovations Driving Progress**
- Advanced solar technologies ☀️
- Efficient wind turbines 🌬
- Geothermal and hydro power 💧
- Energy storage solutions 🔋
> 🌿 *Continuous research is making renewables more accessible and efficient.*
---
### 💡 **Conclusion**
Investing in renewable energy is investing in our future.
> ☀️ *Powering the world sustainably, one innovation at a time.*
', 'Published', 'BTP0003') ON CONFLICT DO NOTHING;
INSERT INTO public."Blog" VALUES ('B0020', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Advocacy in Action: Making Your Voice Heard', '# 🗣️ **Advocacy in Action: Making Your Voice Heard**
> *Your voice has power. Learn how to use it for positive change.*
---
### 🌱 **The Impact of Advocacy**
Advocacy is about speaking up for what''s right. It can:
- Influence policy decisions ⚖️
- Raise public awareness 🧠
- Support vulnerable communities 🤝
> 🌟 *Every voice, no matter how small, can contribute to a larger movement.*
---
### 🛠 **Steps to Effective Advocacy**
- Research your cause thoroughly 📚
- Connect with like-minded individuals/groups 🤝
- Share your story and facts compellingly 📝
- Engage with policymakers and elected officials 🏛️
> 🌿 *Persistence and passion are key to successful advocacy.*
---
### 💡 **Conclusion**
Be an agent of change. Your voice matters.
> 🗣️ *Speak up, stand out, and shape a better world.*
', 'Published', 'BTP0004') ON CONFLICT DO NOTHING;
INSERT INTO public."Blog" VALUES ('B0021', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'The Importance of Community Events', '# 🎉 **The Importance of Community Events**
> *Bringing people together builds stronger, more vibrant communities.*
---
### 🌱 **Benefits of Local Gatherings**
Community events foster:
- Social connection 🤝
- Cultural exchange 🌍
- Local pride 🏘️
- Economic growth 💰
> 🌟 *They are the heartbeats of a thriving neighborhood.*
---
### 🛠 **Types of Engaging Events**
- Festivals and fairs 🎡
- Workshops and seminars 📚
- Clean-up drives and volunteer days 🌱
- Local markets and art shows 🎨
> 🌿 *Variety ensures something for everyone.*
---
### 💡 **Conclusion**
Participate in community events to enrich your life and your neighborhood.
> 🎉 *Celebrate together, grow together, thrive together.*
', 'Published', 'BTP0005') ON CONFLICT DO NOTHING;
INSERT INTO public."Blog" VALUES ('B0022', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Building Strong Family Bonds', '# 👨‍👩‍👧‍👦 **Building Strong Family Bonds**
> *Family is the foundation of support and love. Nurture these connections.*
---
### 🌱 **Why Family Matters**
Strong family bonds provide:
- Emotional security ❤️
- A sense of belonging 🏡
- Resilience during challenges 💪
> 🌟 *They are the first and most enduring support system.*
---
### 🛠 **Practices for Stronger Bonds**
- Spend quality time together ⏰
- Communicate openly and honestly 🗣️
- Share responsibilities and support each other 🤝
- Create shared memories and traditions 📸
> 🌿 *Small daily actions build lasting connections.*
---
### 💡 **Conclusion**
Invest in your family. It''s the most rewarding investment you''ll make.
> 👨‍👩‍👧‍👦 *Love, laughter, and connection: the pillars of family.*
', 'Published', 'BTP0006') ON CONFLICT DO NOTHING;
INSERT INTO public."Blog" VALUES ('B0023', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'The Benefits of Outdoor Exercise', '# 🌳 **The Benefits of Outdoor Exercise**
> *Move your body, connect with nature, and boost your well-being.*
---
### 🌱 **Why Go Outdoors?**
Exercising outside offers unique advantages:
- Fresh air and sunshine ☀️
- Varied terrain for better workouts 🏞️
- Reduced stress and improved mood 🧘‍♀️
> 🌟 *Nature enhances the physical and mental benefits of exercise.*
---
### 🛠 **Outdoor Activities to Try**
- Hiking and trail running 🏃‍♀️
- Cycling and walking 🚴‍♀️
- Outdoor yoga or meditation 🧘‍♂️
- Team sports in a park ⚽
> 🌿 *Find an activity you love and make it a habit.*
---
### 💡 **Conclusion**
Embrace the great outdoors for a healthier, happier you.
> 🌳 *Your body and mind will thank you for it.*
', 'Published', 'BTP0001') ON CONFLICT DO NOTHING;
INSERT INTO public."Blog" VALUES ('B0024', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'The Importance of Early Childhood Education', '# 👶 **The Importance of Early Childhood Education**
> *Laying the foundation for a lifetime of learning and growth.*
---
### 🌱 **Why Early Years Matter**
Quality early education supports:
- Cognitive development 🧠
- Social and emotional skills ❤️
- Problem-solving abilities 🧩
> 🌟 *It sets children up for success in school and life.*
---
### 🛠 **Key Elements of Effective Programs**
- Play-based learning 🎲
- Nurturing environments 🏡
- Qualified educators 🧑‍🏫
- Parental involvement 👨‍👩‍👧‍👦
> 🌿 *A holistic approach fosters well-rounded development.*
---
### 💡 **Conclusion**
Invest in early childhood education for a brighter future for all.
> 👶 *Every child deserves a strong start.*
', 'Published', 'BTP0002') ON CONFLICT DO NOTHING;
INSERT INTO public."Blog" VALUES ('B0025', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Exploring the Wonders of Space', '# 🚀 **Exploring the Wonders of Space**
> *Journey beyond Earth and discover the mysteries of the universe.*
---
### 🌱 **Why Space Exploration?**
Space research pushes boundaries, leading to:
- Scientific breakthroughs 🔬
- Technological advancements 🛰️
- A deeper understanding of our origins 🌌
> 🌟 *It inspires curiosity and innovation.*
---
### 🛠 **Key Discoveries and Missions**
- Discovering exoplanets 🪐
- Landing on Mars 🔴
- The Hubble Space Telescope 🔭
- Future missions to the Moon and beyond 🌕
> 🌿 *Humanity''s quest to explore is endless.*
---
### 💡 **Conclusion**
Look up and wonder. The universe is waiting to be explored.
> 🚀 *Infinite possibilities, endless discoveries.*
', 'Published', 'BTP0003') ON CONFLICT DO NOTHING;
INSERT INTO public."Blog" VALUES ('B0027', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Festivals: Celebrating Culture and Community', '# 🎭 **Festivals: Celebrating Culture and Community**
> *Festivals are vibrant expressions of shared heritage and joy.*
---
### 🌱 **More Than Just Fun**
Festivals offer:
- Cultural preservation and sharing 🌍
- Community bonding and spirit 🎉
- Economic benefits for local businesses 💰
- Opportunities for artistic expression 🎨
> 🌟 *They connect us to our roots and to each other.*
---
### 🛠 **Planning and Participation**
- Research local festivals 📅
- Volunteer to help organize 🤝
- Immerse yourself in the traditions 💃
- Support local artisans and performers 🎶
> 🌿 *Be part of the celebration and create lasting memories.*
---
### 💡 **Conclusion**
Embrace the spirit of festivals and the richness they bring.
> 🎭 *Celebrate diversity, celebrate community.*
', 'Published', 'BTP0005') ON CONFLICT DO NOTHING;
INSERT INTO public."Blog" VALUES ('B0028', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'The Art of Active Listening', '# 👂 **The Art of Active Listening**
> *Listen to understand, not just to reply. Build stronger connections.*
---
### 🌱 **Why Active Listening Matters**
Active listening enhances:
- Empathy and understanding ❤️
- Trust and rapport 🤝
- Conflict resolution ⚖️
- Overall communication effectiveness 🗣️
> 🌟 *It''s a cornerstone of meaningful relationships.*
---
### 🛠 **Techniques for Active Listening**
- Give your full attention (put away distractions) 📵
- Reflect and paraphrase what you hear 🤔
- Ask open-ended questions to encourage sharing 💬
- Observe non-verbal cues 👀
> 🌿 *Practice makes perfect in the art of listening.*
---
### 💡 **Conclusion**
Master active listening to deepen your connections and understanding.
> 👂 *Hear more than just words; hear the meaning behind them.*
', 'Published', 'BTP0006') ON CONFLICT DO NOTHING;
INSERT INTO public."Blog" VALUES ('B0029', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Mindfulness in Everyday Life', '# 🧘‍♀️ **Mindfulness in Everyday Life**
> *Find calm amidst the chaos. Practice presence in every moment.*
---
### 🌱 **What is Mindfulness?**
Mindfulness is paying attention to the present moment without judgment. It helps:
- Reduce stress and anxiety 🌬️
- Improve focus and clarity 🧠
- Enhance emotional regulation ❤️
> 🌟 *It''s about living fully, one moment at a time.*
---
### 🛠 **Simple Mindfulness Practices**
- Mindful breathing exercises 🌬️
- Mindful eating (savoring each bite) 🍎
- Walking meditation 🚶‍♀️
- Body scan meditation 🧘‍♂️
> 🌿 *Even a few minutes a day can make a difference.*
---
### 💡 **Conclusion**
Integrate mindfulness into your daily routine for greater peace and awareness.
> 🧘‍♀️ *Be present. Be calm. Be you.*
', 'Published', 'BTP0001') ON CONFLICT DO NOTHING;
INSERT INTO public."Blog" VALUES ('B0030', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'The Evolution of Education Technology', '# 💻 **The Evolution of Education Technology**
> *From blackboards to AI: how tech is transforming learning.*
---
### 🌱 **Past, Present, and Future**
EdTech has evolved rapidly, impacting:
- Access to knowledge 📚
- Personalized learning experiences 🧑‍🎓
- Global collaboration 🌍
> 🌟 *Technology is reshaping how and where we learn.*
---
### 🛠 **Key Innovations**
- Online learning platforms (MOOCs) 🌐
- Virtual and augmented reality (VR/AR) 👓
- AI-powered tutoring and assessment 🤖
- Gamification in education 🎮
> 🌿 *These tools make learning more engaging and effective.*
---
### 💡 **Conclusion**
Embrace EdTech to unlock new possibilities in learning.
> 💻 *Learning without limits: the promise of technology.*
', 'Published', 'BTP0002') ON CONFLICT DO NOTHING;
INSERT INTO public."Blog" VALUES ('B0031', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'The Ethics of Artificial Intelligence', '# 🤖 **The Ethics of Artificial Intelligence**
> *As AI advances, ethical considerations become paramount.*
---
### 🌱 **Balancing Innovation and Responsibility**
Ethical AI development addresses concerns like:
- Bias in algorithms ⚖️
- Privacy and data security 🔒
- Job displacement 📈
- Autonomous decision-making 🤔
> 🌟 *Ensuring AI benefits humanity requires careful ethical frameworks.*
---
### 🛠 **Key Ethical Principles**
- Transparency and explainability 📊
- Fairness and non-discrimination 🤝
- Accountability and responsibility 🧑‍⚖️
- Human oversight and control 👤
> 🌿 *Building trust in AI requires a commitment to ethical design.*
---
### 💡 **Conclusion**
Engage in the conversation about AI ethics to shape a responsible future.
> 🤖 *Intelligent systems, ethical choices.*
', 'Published', 'BTP0003') ON CONFLICT DO NOTHING;
INSERT INTO public."Blog" VALUES ('B0032', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Grassroots Movements: Power from the People', '# ✊ **Grassroots Movements: Power from the People**
> *Ordinary people driving extraordinary change from the ground up.*
---
### 🌱 **The Strength of Collective Action**
Grassroots movements empower communities by:
- Addressing local issues directly 🏘️
- Fostering civic engagement 🤝
- Creating sustainable change 🌳
> 🌟 *They demonstrate the power of collective will.*
---
### 🛠 **How They Work**
- Community organizing and mobilization 🗣️
- Petitions and local advocacy ✍️
- Direct action and peaceful protests 🚶‍♀️
- Building strong local networks 🌱
> 🌿 *Change often begins with passionate individuals.*
---
### 💡 **Conclusion**
Support and participate in grassroots efforts to build a better world.
> ✊ *Small actions, big impact.*
', 'Published', 'BTP0004') ON CONFLICT DO NOTHING;
INSERT INTO public."Blog" VALUES ('B0033', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'The Impact of Digital Campaigns', '# 📈 **The Impact of Digital Campaigns**
> *Reaching global audiences and driving engagement in the digital age.*
---
### 🌱 **Beyond Traditional Media**
Digital campaigns offer:
- Wider reach and accessibility 🌐
- Targeted messaging 🎯
- Real-time feedback and analytics 📊
- Cost-effectiveness 💰
> 🌟 *They have revolutionized how information is shared and movements are built.*
---
### 🛠 **Elements of Successful Campaigns**
- Compelling content (videos, infographics) 🎬
- Strategic use of social media 📱
- Influencer collaborations 🤝
- Clear calls to action ✅
> 🌿 *Creativity and data drive digital success.*
---
### 💡 **Conclusion**
Harness the power of digital campaigns for your cause.
> 📈 *Amplify your message, maximize your impact.*
', 'Published', 'BTP0005') ON CONFLICT DO NOTHING;
INSERT INTO public."Blog" VALUES ('B0034', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'The Importance of Social Skills in Youth', '# 🗣️ **The Importance of Social Skills in Youth**
> *Equipping young people with the tools for successful interactions.*
---
### 🌱 **Foundations for Life**
Strong social skills enable youth to:
- Build healthy relationships 🤝
- Communicate effectively 💬
- Navigate diverse social situations 🌍
- Develop empathy and understanding ❤️
> 🌟 *They are crucial for academic, professional, and personal success.*
---
### 🛠 **How to Foster Social Skills**
- Encourage active listening 👂
- Promote teamwork and collaboration 🧑‍🤝‍🧑
- Teach conflict resolution strategies ⚖️
- Model positive social behaviors 👨‍👩‍👧‍👦
> 🌿 *Practice and positive reinforcement are key.*
---
### 💡 **Conclusion**
Invest in developing social skills for a well-rounded and successful future.
> 🗣️ *Connect, communicate, thrive.*
', 'Published', 'BTP0006') ON CONFLICT DO NOTHING;
INSERT INTO public."Blog" VALUES ('B0035', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'The Benefits of a Balanced Diet', '# 🍎 **The Benefits of a Balanced Diet**
> *Fuel your body and mind with nutritious choices for optimal health.*
---
### 🌱 **More Than Just Calories**
A balanced diet provides:
- Essential nutrients for energy and growth 💪
- Support for a strong immune system 🛡️
- Improved mood and cognitive function 🧠
- Reduced risk of chronic diseases 🏥
> 🌟 *Food is medicine. Eat well, live well.*
---
### 🛠 **Building a Balanced Plate**
- Include a variety of fruits and vegetables 🥦
- Choose lean proteins and whole grains 🍞
- Limit processed foods and excessive sugars 🍬
- Stay hydrated with water 💧
> 🌿 *Small, consistent changes lead to big health benefits.*
---
### 💡 **Conclusion**
Prioritize a balanced diet for a healthier, more vibrant life.
> 🍎 *Nourish your body, flourish your life.*
', 'Published', 'BTP0001') ON CONFLICT DO NOTHING;
INSERT INTO public."Blog" VALUES ('B0036', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Lifelong Learning: Never Stop Growing', '# 📚 **Lifelong Learning: Never Stop Growing**
> *The world is constantly evolving. Keep learning to stay ahead and enrich your life.*
---
### 🌱 **Why Continuous Learning?**
Lifelong learning offers:
- Adaptability in a changing world 🔄
- Personal and professional growth 📈
- Enhanced problem-solving skills 🧩
- Increased curiosity and fulfillment ✨
> 🌟 *Learning is a journey, not a destination.*
---
### 🛠 **Ways to Embrace Learning**
- Read widely and consistently 📖
- Take online courses or workshops 💻
- Learn a new skill or hobby 🎨
- Engage in meaningful conversations 💬
> 🌿 *Every day is an opportunity to learn something new.*
---
### 💡 **Conclusion**
Embrace lifelong learning to unlock your full potential.
> 📚 *Grow your mind, expand your world.*
', 'Published', 'BTP0002') ON CONFLICT DO NOTHING;
INSERT INTO public."Blog" VALUES ('B0037', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'The Science of Sleep: Why You Need It', '# 😴 **The Science of Sleep: Why You Need It**
> *Sleep is not a luxury; It''s a biological necessity for health and well-being.*
---
### 🌱 **Beyond Just Rest**
Quality sleep is vital for:
- Brain function and memory consolidation 🧠
- Physical recovery and repair 💪
- Emotional regulation and mood stability ❤️
- Immune system strength 🛡️
> 🌟 *Prioritize sleep for a healthier, more productive life.*
---
### 🛠 **Tips for Better Sleep**
- Maintain a consistent sleep schedule ⏰
- Create a relaxing bedtime routine 🌙
- Ensure a dark, quiet, and cool sleep environment 🛌
- Limit caffeine and screens before bed 📵
> 🌿 *Small changes can lead to significant improvements in sleep quality.*
---
### 💡 **Conclusion**
Understand and prioritize sleep for optimal health.
> 😴 *Rest well, live fully.*
', 'Published', 'BTP0001') ON CONFLICT DO NOTHING;
INSERT INTO public."Blog" VALUES ('B0038', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'The Role of Data in Modern Society', '# 📊 **The Role of Data in Modern Society**
> *Data is the new oil, driving innovation and decision-making across industries.*
---
### 🌱 **From Raw Facts to Insights**
Data impacts:
- Business strategies 📈
- Scientific research 🔬
- Public policy development 🏛️
- Personalized experiences 🛍️
> 🌟 *Understanding data is key to navigating the modern world.*
---
### 🛠 **Ethical Considerations**
- Data privacy and security 🔒
- Algorithmic bias ⚖️
- Transparency in data collection 🗣️
- Responsible use of insights ✅
> 🌿 *Ethical data practices are crucial for trust and fairness.*
---
### 💡 **Conclusion**
Embrace data literacy to thrive in an increasingly data-driven world.
> 📊 *Data: informing, transforming, and shaping our future.*
', 'Published', 'BTP0003') ON CONFLICT DO NOTHING;
INSERT INTO public."Blog" VALUES ('B0039', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Global Health Initiatives', '# 🌍 **Global Health Initiatives**
> *Working together across borders for a healthier world.*
---
### 🌱 **Addressing Worldwide Challenges**
Global health initiatives tackle issues like:
- Infectious diseases (e.g., pandemics) 🦠
- Maternal and child health 👶
- Access to clean water and sanitation 💧
- Non-communicable diseases (e.g., diabetes) 🏥
> 🌟 *Collaboration is essential for universal well-being.*
---
### 🛠 **Key Strategies**
- Vaccine development and distribution 💉
- Strengthening health systems 🧑‍⚕️
- Health education and awareness campaigns 📚
- Research and innovation 🔬
> 🌿 *Collective effort leads to significant impact.*
---
### 💡 **Conclusion**
Support global health initiatives to create a healthier, more equitable world.
> 🌍 *Health for all: a shared vision.*
', 'Published', 'BTP0004') ON CONFLICT DO NOTHING;
INSERT INTO public."Blog" VALUES ('B0040', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'The Power of Storytelling in Advocacy', '# 📖 **The Power of Storytelling in Advocacy**
> *Stories move hearts and minds, driving change more powerfully than facts alone.*
---
### 🌱 **Why Stories Resonate**
Stories:
- Create empathy and connection ❤️
- Make complex issues relatable 🤔
- Inspire action and engagement 💪
- Are memorable and shareable 🗣️
> 🌟 *Humanize your message to maximize its impact.*
---
### 🛠 **Crafting Effective Stories**
- Focus on personal experiences 🧑‍🤝‍🧑
- Highlight challenges and triumphs 📈
- Include a clear call to action ✅
- Use vivid language and imagery 🎨
> 🌿 *Authenticity is key to powerful storytelling.*
---
### 💡 **Conclusion**
Use storytelling to amplify your advocacy efforts and inspire change.
> 📖 *Tell your truth, change the world.*
', 'Published', 'BTP0005') ON CONFLICT DO NOTHING;
INSERT INTO public."Blog" VALUES ('B0041', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Building a Supportive Community Network', '# 🤝 **Building a Supportive Community Network**
> *No one thrives alone. Cultivate connections that lift you up.*
---
### 🌱 **Benefits of Strong Networks**
A supportive community provides:
- Emotional support and encouragement ❤️
- Practical assistance and resources 🛠️
- A sense of belonging and shared purpose 🏘️
- Opportunities for growth and collaboration 🌱
> 🌟 *It''s a safety net and a springboard for success.*
---
### 🛠 **Ways to Build Your Network**
- Join local clubs or groups 🧑‍🤝‍🧑
- Volunteer for causes you care about 🌳
- Attend community events 🎉
- Reach out to neighbors and colleagues 🗣️
> 🌿 *Be proactive in seeking and offering support.*
---
### 💡 **Conclusion**
Invest in building a strong community network for mutual growth and well-being.
> 🤝 *Together, we are stronger.*
', 'Published', 'BTP0006') ON CONFLICT DO NOTHING;
INSERT INTO public."Blog" VALUES ('B0042', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'The Importance of Hydration', '# 💧 **The Importance of Hydration**
> *Water is essential for life. Stay hydrated for optimal health and energy.*
---
### 🌱 **More Than Just Thirst**
Proper hydration supports:
- Body temperature regulation 🌡️
- Nutrient transport and absorption 🍎
- Organ function and detoxification 🚽
- Energy levels and cognitive function 🧠
> 🌟 *Every cell in your body needs water to function correctly.*
---
### 🛠 **Tips for Staying Hydrated**
- Drink water consistently throughout the day ⏰
- Carry a reusable water bottle 
- Eat water-rich foods (fruits, vegetables) 🍉
- Listen to your body''s thirst signals 🗣️
> 🌿 *Make hydration a daily habit for better health.*
---
### 💡 **Conclusion**
Prioritize water intake for a healthier, more energized you.
> 💧 *Drink up, live well.*
', 'Published', 'BTP0001') ON CONFLICT DO NOTHING;
INSERT INTO public."Blog" VALUES ('B0043', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Learning a New Language: Benefits and Tips', '# 🗣️ **Learning a New Language: Benefits and Tips**
> *Expand your horizons, connect with new cultures, and boost your brainpower.*
---
### 🌱 **Why Learn a Language?**
Language learning offers:
- Cognitive benefits (improved memory, problem-solving) 🧠
- Cultural understanding and empathy 🌍
- Enhanced travel experiences ✈️
- Career opportunities 💼
> 🌟 *It''s a journey of discovery and personal growth.*
---
### 🛠 **Effective Learning Strategies**
- Practice regularly (daily, if possible) ⏰
- Immerse yourself in the language (music, movies) 🎶
- Find a language partner or tutor 🤝
- Don''t be afraid to make mistakes 😅
> 🌿 *Consistency and immersion are key to fluency.*
---
### 💡 **Conclusion**
Embark on the exciting adventure of language learning.
> 🗣️ *Open your mind, open your world.*
', 'Published', 'BTP0002') ON CONFLICT DO NOTHING;
INSERT INTO public."Blog" VALUES ('B0044', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'The Science of Happiness', '# 😊 **The Science of Happiness**
> *Unlocking the secrets to a more joyful and fulfilling life.*
---
### 🌱 **More Than Just a Feeling**
Happiness is influenced by:
- Brain chemistry (neurotransmitters) 🧠
- Lifestyle choices (exercise, sleep) 🏃‍♀️
- Social connections 🤝
- Purpose and meaning ✨
> 🌟 *It''s a complex interplay of biology, psychology, and environment.*
---
### 🛠 **Practices for Cultivating Happiness**
- Practice gratitude and positive affirmations 🙏
- Engage in acts of kindness ❤️
- Spend time in nature 🌳
- Pursue hobbies and passions 🎨
> 🌿 *Small daily habits can significantly boost your well-being.*
---
### 💡 **Conclusion**
Understand the science of happiness to intentionally build a more joyful life.
> 😊 *Choose joy, live fully.*
', 'Published', 'BTP0003') ON CONFLICT DO NOTHING;
INSERT INTO public."Blog" VALUES ('B0045', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Citizen Science: Contributing to Research', '# 🔬 **Citizen Science: Contributing to Research**
> *Anyone can be a scientist! Join projects and make a real impact.*
---
### 🌱 **Democratizing Discovery**
Citizen science allows individuals to:
- Collect valuable data for research 📊
- Contribute to scientific breakthroughs 🧪
- Learn about scientific processes 📚
- Engage with the scientific community 🤝
> 🌟 *It''s a powerful way to accelerate discovery.*
---
### 🛠 **How to Get Involved**
- Find projects online (e.g., bird counting, galaxy classification) 🔭
- Use smartphone apps for data collection 📱
- Participate in local environmental monitoring 🌳
- Transcribe historical documents 📜
> 🌿 *No special training needed, just curiosity and dedication.*
---
### 💡 **Conclusion**
Become a citizen scientist and contribute to the advancement of knowledge.
> 🔬 *Your observations can change the world.*
', 'Published', 'BTP0004') ON CONFLICT DO NOTHING;


--
-- TOC entry 4963 (class 0 OID 17476)
-- Dependencies: 223
-- Data for Name: BlogTopic; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."BlogTopic" VALUES ('BTP0001', 'Health & Wellness') ON CONFLICT DO NOTHING;
INSERT INTO public."BlogTopic" VALUES ('BTP0002', 'Education') ON CONFLICT DO NOTHING;
INSERT INTO public."BlogTopic" VALUES ('BTP0003', 'Science & Research') ON CONFLICT DO NOTHING;
INSERT INTO public."BlogTopic" VALUES ('BTP0004', 'Policy & Advocacy') ON CONFLICT DO NOTHING;
INSERT INTO public."BlogTopic" VALUES ('BTP0005', 'Events & Campaigns') ON CONFLICT DO NOTHING;
INSERT INTO public."BlogTopic" VALUES ('BTP0006', 'Social Life') ON CONFLICT DO NOTHING;


--
-- TOC entry 4964 (class 0 OID 17481)
-- Dependencies: 224
-- Data for Name: Campaign; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Campaign" VALUES ('CAM0001', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Youth Mental Health Awareness', 'A campaign focused on raising awareness about mental health issues among youth and providing resources.', '2025-06-01', '2025-07-31', 'Active', 'Elementary School At District 3, Ho Chi Minh City', 'A National Campaign for Mental Wellness in the Next Generation

Mental health issues among youth have become a silent crisis in many societies around the world. The "Youth Mental Health Awareness" campaign is a national initiative dedicated to shining a light on the challenges faced by adolescents and young adults when it comes to mental well-being. With rising cases of anxiety, depression, stress-related disorders, and even suicide among teenagers, this campaign seeks to break the silence and stigma surrounding mental health through open dialogue, education, and accessible support.

The campaign is designed to operate across major cities and educational institutions, especially high schools and universities, where students are often most vulnerable to emotional and psychological pressures. Through workshops, webinars, and in-person forums, the campaign provides a safe platform for youth to express their concerns, learn about mental health topics, and connect with licensed professionals. Additionally, we aim to involve parents, educators, and community leaders in these sessions to build a supportive environment around young individuals.

One of the key features of the campaign is its mobile mental health support unit, which travels to underserved areas to provide free counseling services and distribute educational materials. Parallel to this, an online resource hub will be launched, offering articles, videos, self-help tools, and a 24/7 chat system with mental health professionals. By combining digital and physical outreach, the campaign ensures that no student is left behind—no matter their location or background.

In collaboration with public health departments, youth organizations, and schools, "Youth Mental Health Awareness" promotes mental fitness as an essential component of overall well-being. The campaign encourages students to prioritize self-care, recognize early warning signs of mental distress, and seek help without shame. Through real stories, social media challenges, and youth-led content creation, we aim to normalize conversations around mental health and empower young people to take ownership of their emotional resilience.

Ultimately, this campaign is more than a series of events—it''s a movement toward a future where mental health is treated with the same importance as physical health. We believe that by raising awareness, providing tools, and creating open spaces for support, we can foster a generation that is mentally strong, emotionally aware, and unafraid to ask for help. Together, we can build communities where every young person feels seen, heard, and supported.') ON CONFLICT DO NOTHING;
INSERT INTO public."Campaign" VALUES ('CAM0002', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Drug Prevention in Schools', 'Initiative to conduct workshops and seminars in local schools to educate students on drug prevention.', '2025-09-01', '2025-12-15', 'Planned', 'High School At District 1', 'The “Drug Prevention in Schools” campaign is a strategic initiative designed to educate and empower students to make informed, healthy choices regarding drug use. With rising concerns about substance abuse among teenagers, this campaign brings a focused, community-based approach to prevention, rooted in early intervention and education. Our goal is to provide accurate information, cultivate strong personal values, and create a supportive school environment where students are equipped to resist peer pressure and substance temptation.

At the heart of the campaign are interactive workshops and expert-led seminars conducted across middle and high schools. These sessions are not just lectures but engaging experiences involving role-playing, storytelling, multimedia presentations, and open discussions. Students learn about the short- and long-term effects of drug use, how to identify risky situations, and where to seek help if they or someone they know is struggling. Tailored content ensures that each age group receives information in a way that resonates and sticks.

The campaign also actively involves school staff and parents through specialized training sessions and community forums. Teachers are given guidance on recognizing behavioral changes, while parents are encouraged to build open communication channels at home. By working together, we ensure that prevention extends beyond the classroom into homes and communities. This unified front significantly increases the impact of our messaging and ensures continuity in the students’ support systems.

Another key element is peer involvement. The campaign trains selected students to become youth ambassadors — confident, informed voices within their schools. These peer leaders host small-group discussions, organize awareness events, and model healthy lifestyles. By empowering youth to take ownership of the message, we cultivate a culture of shared responsibility and peer-to-peer influence, which research has shown to be one of the most effective tools in drug prevention.

In the long term, the “Drug Prevention in Schools” campaign aims to shift the narrative around substance use — from taboo or curiosity to understanding and prevention. It’s not just about saying “no” to drugs; it’s about giving students the tools, confidence, and support they need to say “yes” to a safer, healthier future. Every student deserves to thrive in a drug-free environment, and with sustained effort, collaboration, and compassion, we believe that goal is fully within reach.') ON CONFLICT DO NOTHING;
INSERT INTO public."Campaign" VALUES ('CAM0026', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Holiday Food Drive', 'Collecting food donations for families in need during the holiday season.', '2025-11-25', '2025-12-25', 'Planned', 'Community Food Bank', 'Spreading warmth and nourishment during the holidays.') ON CONFLICT DO NOTHING;
INSERT INTO public."Campaign" VALUES ('CAM0027', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Youth Leadership Camp', 'A week-long camp to develop leadership skills and teamwork among teenagers.', '2025-12-02', '2025-12-09', 'Active', 'Outdoor Leadership Center', 'Building future leaders through immersive experiences.') ON CONFLICT DO NOTHING;
INSERT INTO public."Campaign" VALUES ('CAM0028', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Art Therapy Sessions', 'Offering therapeutic art sessions for stress relief and emotional expression.', '2025-12-09', NULL, 'Planned', 'Art Therapy Studio', 'Healing through creativity: art as a path to well-being.') ON CONFLICT DO NOTHING;
INSERT INTO public."Campaign" VALUES ('CAM0029', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Winter Clothing Drive', 'Collecting warm clothing for the homeless and needy during winter.', '2025-12-16', '2026-01-16', 'Active', 'Donation Center', 'Keeping our community warm during the cold months.') ON CONFLICT DO NOTHING;
INSERT INTO public."Campaign" VALUES ('CAM0030', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'New Year''s Resolution Workshop', 'Workshops to help individuals set and achieve their New Year''s goals.', '2025-12-23', '2026-01-23', 'Planned', 'Community Event Hall', 'Start the new year strong: setting achievable goals for a better you.') ON CONFLICT DO NOTHING;
INSERT INTO public."Campaign" VALUES ('CAM0031', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Gardening for Wellness', 'Promoting mental and physical health through community gardening.', '2025-12-30', NULL, 'Active', 'Community Garden', 'Cultivating health and happiness through gardening.') ON CONFLICT DO NOTHING;
INSERT INTO public."Campaign" VALUES ('CAM0032', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Youth Entrepreneurship Program', 'A program to foster entrepreneurial skills among young people.', '2026-01-06', '2026-03-06', 'Planned', 'Innovation Hub', 'Nurturing the next generation of innovators and business leaders.') ON CONFLICT DO NOTHING;
INSERT INTO public."Campaign" VALUES ('CAM0033', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Healthy Sleep Habits Seminar', 'Educating on the importance of sleep and techniques for better sleep.', '2026-01-13', '2026-02-13', 'Active', 'Online Webinar', 'Unlock the power of good sleep for better health and productivity.') ON CONFLICT DO NOTHING;
INSERT INTO public."Campaign" VALUES ('CAM0034', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Anti-Bullying Awareness', 'A campaign to raise awareness and prevent bullying in schools and communities.', '2026-01-20', NULL, 'Planned', 'School Auditoriums', 'Creating safe and inclusive environments for everyone.') ON CONFLICT DO NOTHING;
INSERT INTO public."Campaign" VALUES ('CAM0035', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Digital Detox Challenge', 'Encouraging a break from digital devices to improve mental well-being.', '2026-01-27', '2026-03-27', 'Active', 'Online Platform', 'Reclaim your time and mind with a digital detox.') ON CONFLICT DO NOTHING;
INSERT INTO public."Campaign" VALUES ('CAM0036', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Home Safety Workshop', 'Workshops on ensuring safety within the home environment.', '2026-02-03', '2026-04-03', 'Planned', 'Community Safety Center', 'Making homes safer for families and individuals.') ON CONFLICT DO NOTHING;
INSERT INTO public."Campaign" VALUES ('CAM0037', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Creative Writing Club', 'A club for aspiring writers to develop their skills and share their work.', '2026-02-10', NULL, 'Active', 'Local Bookstore', 'Unleash your inner storyteller and connect with fellow writers.') ON CONFLICT DO NOTHING;
INSERT INTO public."Campaign" VALUES ('CAM0038', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Public Speaking Masterclass', 'A masterclass to improve public speaking and presentation skills.', '2026-02-17', '2026-04-17', 'Planned', 'Conference Room', 'Speak with confidence and impact.') ON CONFLICT DO NOTHING;
INSERT INTO public."Campaign" VALUES ('CAM0039', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Mindfulness & Meditation Series', 'A series of sessions on mindfulness and meditation for stress reduction.', '2026-02-24', '2026-03-24', 'Active', 'Wellness Studio', 'Find your inner calm through mindfulness and meditation.') ON CONFLICT DO NOTHING;
INSERT INTO public."Campaign" VALUES ('CAM0040', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Coding Bootcamp for Adults', 'An intensive coding bootcamp for adults looking to switch careers.', '2026-03-03', NULL, 'Planned', 'Tech Training Center', 'Transform your career with in-demand coding skills.') ON CONFLICT DO NOTHING;
INSERT INTO public."Campaign" VALUES ('CAM0041', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Community Sports League', 'Organizing a local sports league to promote physical activity and community bonding.', '2026-03-10', '2026-05-10', 'Active', 'Community Sports Fields', 'Get active and connect with your neighbors through sports.') ON CONFLICT DO NOTHING;
INSERT INTO public."Campaign" VALUES ('CAM0042', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Healthy Relationships Workshop', 'Workshops focusing on building and maintaining healthy relationships.', '2026-03-17', '2026-05-17', 'Planned', 'Family Resource Center', 'Nurturing strong and supportive relationships.') ON CONFLICT DO NOTHING;
INSERT INTO public."Campaign" VALUES ('CAM0043', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Youth Photography Contest', 'A photography contest for young artists to showcase their talent.', '2026-03-24', NULL, 'Active', 'Art Gallery', 'Capturing creativity: a showcase for young photographers.') ON CONFLICT DO NOTHING;
INSERT INTO public."Campaign" VALUES ('CAM0044', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Basic Computer Skills Class', 'Classes for beginners to learn essential computer skills.', '2026-03-31', '2026-06-30', 'Planned', 'Public Library Computer Lab', 'Bridging the digital divide with essential computer knowledge.') ON CONFLICT DO NOTHING;
INSERT INTO public."Campaign" VALUES ('CAM0045', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Local History Tour', 'Organized tours to explore the rich history of the local area.', '2026-04-07', '2026-05-07', 'Active', 'Historical Landmarks', 'Discovering the stories that shaped our community.') ON CONFLICT DO NOTHING;
INSERT INTO public."Campaign" VALUES ('CAM0003', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Community Outreach Program', 'Engaging with local communities through events and support groups.', '2025-03-01', '2025-05-31', 'Completed', 'Secondary School At district 5', 'The Community Outreach Program is a compassionate initiative aimed at building meaningful relationships with local communities through engagement, education, and empowerment. In many neighborhoods, especially those facing social and economic challenges, there is a growing need for trusted programs that foster connection and provide reliable support. This campaign is designed to meet people where they are—physically, emotionally, and culturally—through grassroots efforts and inclusive events.

At the center of the campaign are regularly hosted community events, such as health fairs, cultural celebrations, and public awareness days. These events serve as platforms to share knowledge, offer services, and create safe spaces for dialogue on critical issues such as drug prevention, mental health, youth development, and family support. Each event is customized based on the local context, ensuring that the content, language, and delivery resonate deeply with the audience.

Beyond public gatherings, the program facilitates support groups and community circles where individuals can come together to share experiences, access peer support, and receive guidance from trained counselors and facilitators. Whether it''s a group for parents, at-risk youth, or recovering individuals, the goal is to reduce isolation and increase resilience through connection and empathy. These safe, confidential spaces are instrumental in healing and empowerment.

The campaign also emphasizes collaboration with local stakeholders, including schools, faith-based organizations, NGOs, and health clinics. By building strong partnerships, the program ensures a wide reach and greater sustainability. Volunteers from the community are recruited and trained to serve as outreach ambassadors, extending the program’s impact and fostering a sense of ownership and leadership within the neighborhood.

Ultimately, the Community Outreach Program is about more than delivering services—it’s about cultivating trust, breaking barriers, and promoting lasting change from within. When people feel heard, valued, and supported, entire communities begin to thrive. Through consistent engagement, compassionate listening, and accessible resources, this campaign strives to build a foundation of hope, dignity, and mutual support for everyone it touches.') ON CONFLICT DO NOTHING;
INSERT INTO public."Campaign" VALUES ('CAM0004', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Safe Spaces for Teens', 'Creating safe, supportive environments where teenagers can talk freely about mental health and substance use.', '2025-06-16', '2025-06-27', 'Active', '133', 'In today’s rapidly changing world, teenagers face unprecedented challenges that impact their mental well-being and personal development. Social pressures, academic stress, and exposure to digital media have created environments where teens often feel isolated, misunderstood, or afraid to speak openly about their struggles. The "Safe Spaces for Teens" campaign is designed to break down these barriers and foster environments of trust, empathy, and open communication.

The initiative centers around the idea that every teen deserves a place where they can be heard without fear of judgment or punishment. Through the creation of peer support groups, school-based counseling corners, and community outreach programs, the campaign seeks to normalize conversations around mental health and substance use. These spaces are built not just physically but culturally — reshaping how adults and institutions listen to and support youth.

A key component of the campaign involves training educators, youth workers, and volunteers to recognize early signs of emotional distress and substance-related behaviors. By equipping these stakeholders with the right tools and language, Safe Spaces become proactive rather than reactive — identifying problems before they escalate and guiding teens toward appropriate resources and care.

In addition to professional support, the campaign emphasizes peer engagement. Teen-led forums, creative expression workshops, and storytelling sessions allow youth to connect, share experiences, and build resilience together. These activities help dismantle stigma and promote a collective sense of agency and understanding among participants.

Ultimately, "Safe Spaces for Teens" is more than just a campaign — it''s a commitment to long-term cultural change. By embedding empathy, inclusivity, and mental health literacy into the fabric of schools and communities, we aim to create a future where every teen feels seen, supported, and safe to be themselves.') ON CONFLICT DO NOTHING;
INSERT INTO public."Campaign" VALUES ('CAM0005', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Environmental Awareness Drive', 'A campaign focused on promoting environmental sustainability and eco-friendly practices.', '2025-07-01', '2025-08-31', 'Active', 'City Park Green Zone', 'This campaign aims to educate the public on environmental issues and encourage sustainable living.') ON CONFLICT DO NOTHING;
INSERT INTO public."Campaign" VALUES ('CAM0006', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Youth Empowerment Summit', 'An initiative to empower young individuals through leadership workshops and skill-building sessions.', '2025-07-08', '2025-09-08', 'Planned', 'Youth Community Hall', 'Empowering the next generation with essential skills and leadership qualities.') ON CONFLICT DO NOTHING;
INSERT INTO public."Campaign" VALUES ('CAM0007', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Healthy Living Challenge', 'Promoting a healthier lifestyle through fitness activities and nutritional guidance.', '2025-07-15', NULL, 'Active', 'Online Platform', 'Join our challenge to adopt healthier habits and improve overall well-being.') ON CONFLICT DO NOTHING;
INSERT INTO public."Campaign" VALUES ('CAM0008', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Digital Literacy Workshop', 'A series of workshops designed to improve digital literacy skills for all age groups.', '2025-07-22', '2025-09-22', 'Planned', 'Local Library', 'Enhancing digital skills for a more connected and informed community.') ON CONFLICT DO NOTHING;
INSERT INTO public."Campaign" VALUES ('CAM0009', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Community Art Project', 'A collaborative art project to beautify public spaces and foster community spirit.', '2025-07-29', '2025-10-29', 'Active', 'Downtown Art Square', 'Bringing art and community together to create vibrant public spaces.') ON CONFLICT DO NOTHING;
INSERT INTO public."Campaign" VALUES ('CAM0010', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Financial Wellness Seminar', 'Seminars offering practical advice on personal finance, budgeting, and investment.', '2025-08-05', NULL, 'Planned', 'Community Center Auditorium', 'Equipping individuals with the knowledge to achieve financial stability.') ON CONFLICT DO NOTHING;
INSERT INTO public."Campaign" VALUES ('CAM0011', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Volunteer Recruitment Drive', 'A campaign to recruit new volunteers for various community service initiatives.', '2025-08-12', '2025-10-12', 'Active', 'Volunteer Hub', 'Join us in making a difference in our community through volunteering.') ON CONFLICT DO NOTHING;
INSERT INTO public."Campaign" VALUES ('CAM0012', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Local Business Support', 'Promoting and supporting local businesses to boost the regional economy.', '2025-08-19', '2025-11-19', 'Planned', 'Local Market Square', 'Supporting the backbone of our community: local businesses.') ON CONFLICT DO NOTHING;
INSERT INTO public."Campaign" VALUES ('CAM0013', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Mental Health First Aid Training', 'Providing essential training on how to respond to mental health crises.', '2025-08-26', NULL, 'Active', 'Online Platform', 'Learn to provide initial support to those experiencing mental health challenges.') ON CONFLICT DO NOTHING;
INSERT INTO public."Campaign" VALUES ('CAM0014', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Senior Wellness Program', 'A program dedicated to promoting physical and mental well-being among senior citizens.', '2025-09-02', '2025-12-02', 'Planned', 'Senior Community Center', 'Enhancing the quality of life for our senior community members.') ON CONFLICT DO NOTHING;
INSERT INTO public."Campaign" VALUES ('CAM0015', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Reading Challenge for Kids', 'Encouraging children to read more through a fun and interactive reading challenge.', '2025-09-09', '2025-11-09', 'Active', 'Children''s Library', 'Fostering a love for reading in the younger generation.') ON CONFLICT DO NOTHING;
INSERT INTO public."Campaign" VALUES ('CAM0016', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Healthy Eating Workshop', 'Workshops focused on healthy eating habits and meal preparation.', '2025-09-16', NULL, 'Planned', 'Community Kitchen', 'Delicious and nutritious: learn to cook for a healthier you.') ON CONFLICT DO NOTHING;
INSERT INTO public."Campaign" VALUES ('CAM0017', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Youth Sports Festival', 'An annual sports festival to promote physical activity and teamwork among youth.', '2025-09-23', '2025-10-23', 'Active', 'City Sports Complex', 'Celebrating youth, sports, and healthy competition.') ON CONFLICT DO NOTHING;
INSERT INTO public."Campaign" VALUES ('CAM0018', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'First Aid & CPR Training', 'Certified training sessions for first aid and CPR.', '2025-09-30', '2025-12-30', 'Planned', 'Emergency Services Training Center', 'Equipping citizens with life-saving skills.') ON CONFLICT DO NOTHING;
INSERT INTO public."Campaign" VALUES ('CAM0019', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Neighborhood Clean-up Day', 'A community-wide event to clean and beautify local neighborhoods.', '2025-10-07', NULL, 'Active', 'Various Neighborhoods', 'Working together for cleaner and greener communities.') ON CONFLICT DO NOTHING;
INSERT INTO public."Campaign" VALUES ('CAM0020', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Career Development Fair', 'A fair connecting job seekers with potential employers and career development resources.', '2025-10-14', '2026-01-14', 'Planned', 'Convention Center', 'Opening doors to new career opportunities.') ON CONFLICT DO NOTHING;
INSERT INTO public."Campaign" VALUES ('CAM0021', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Pet Adoption Drive', 'A campaign to find loving homes for rescued animals.', '2025-10-21', '2025-12-21', 'Active', 'Animal Shelter', 'Giving furry friends a second chance at a loving home.') ON CONFLICT DO NOTHING;
INSERT INTO public."Campaign" VALUES ('CAM0022', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Elderly Care Awareness', 'Raising awareness about the importance of elderly care and support systems.', '2025-10-28', NULL, 'Planned', 'Community Outreach Center', 'Advocating for compassionate care for our elders.') ON CONFLICT DO NOTHING;
INSERT INTO public."Campaign" VALUES ('CAM0023', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Coding for Kids Program', 'An introductory coding program for children to develop computational thinking skills.', '2025-11-04', '2026-01-04', 'Active', 'Tech Hub Classroom', 'Igniting young minds with the power of coding.') ON CONFLICT DO NOTHING;
INSERT INTO public."Campaign" VALUES ('CAM0024', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Disaster Preparedness Workshop', 'Workshops to educate the public on how to prepare for natural disasters.', '2025-11-11', '2026-02-11', 'Planned', 'Emergency Management Office', 'Staying safe: preparing our community for any emergency.') ON CONFLICT DO NOTHING;
INSERT INTO public."Campaign" VALUES ('CAM0025', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Sustainable Fashion Initiative', 'Promoting eco-friendly and ethical practices in the fashion industry.', '2025-11-18', NULL, 'Active', 'Fashion Institute', 'Fashion with a conscience: embracing sustainability in style.') ON CONFLICT DO NOTHING;


--
-- TOC entry 4965 (class 0 OID 17486)
-- Dependencies: 225
-- Data for Name: CampaignRegistrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."CampaignRegistrations" VALUES ('8c3943d5-96f6-4351-9072-80b239053fd2', 'c6e1b498-7d6d-4da8-9f6a-407ff21e98e4', 'CAM0004', '2025-06-19') ON CONFLICT DO NOTHING;
INSERT INTO public."CampaignRegistrations" VALUES ('faeed6bf-edcf-46eb-94a1-c62f3d82de8b', 'c6e1b498-7d6d-4da8-9f6a-407ff21e98e4', 'CAM0001', '2025-06-19') ON CONFLICT DO NOTHING;
INSERT INTO public."CampaignRegistrations" VALUES ('394e9c32-6882-4f73-96f4-daee4df430e5', 'c96d8d61-93dd-4637-9f21-a9df16162890', 'CAM0004', '2025-06-21') ON CONFLICT DO NOTHING;
INSERT INTO public."CampaignRegistrations" VALUES ('786e0c3b-3898-4f9e-8e3f-4f1c3d2d4144', 'c96d8d61-93dd-4637-9f21-a9df16162890', 'CAM0002', '2025-07-14') ON CONFLICT DO NOTHING;


--
-- TOC entry 4966 (class 0 OID 17491)
-- Dependencies: 226
-- Data for Name: Course; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Course" VALUES ('C0002', 'TP0002', 'Vaping & Social Media: Spot The Lies. Protect Yourself', 'Online', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'This course uncovers the hidden marketing tactics, misleading claims, and social pressures that drive vaping trends, particularly through online platforms. Learn to identify false information, understand the real health impacts, and develop strategies to resist peer pressure and advertising ploys. Empower yourself with facts to make informed decisions and safeguard your health in the digital age.', '5481541a-60c6-4699-ac0d-12a968525faa') ON CONFLICT DO NOTHING;
INSERT INTO public."Course" VALUES ('C0003', 'TP0003', 'Stress Survival Kit: Healthy Alternatives to Substances', 'Online', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'This course explores a range of practical, evidence-based techniques, from mindfulness and relaxation exercises to healthy coping mechanisms and building resilient support systems. Learn to identify your personal stress triggers, develop a personalized toolkit of constructive alternatives, and cultivate emotional well-being. Discover how to navigate life''s challenges with greater calm, clarity, and inner strength, fostering a healthier and more balanced lifestyle.', '5481541a-60c6-4699-ac0d-12a968525faa') ON CONFLICT DO NOTHING;
INSERT INTO public."Course" VALUES ('C0004', 'TP0004', 'The Teen Drug Talk: How to Not Make It Awkward', 'Online', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'This course moves beyond fear-based tactics, offering strategies to foster open communication, build trust, and address sensitive topics with genuine understanding. Learn how to initiate conversations, listen effectively, respond to tough questions, and empower teens to make healthy choices without resorting to lectures or judgment. Equip yourself with the confidence and tools to transform a potentially awkward discussion into a supportive and impactful dialogue.', '5481541a-60c6-4699-ac0d-12a968525faa') ON CONFLICT DO NOTHING;
INSERT INTO public."Course" VALUES ('C0005', 'TP0005', 'Overdose 101: Recognize the Signs & Save a Life', 'Online', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'This course teaches participants how to identify the signs of an overdose, understand the vital role of naloxone (Narcan), and confidently administer this emergency medication. Through practical instruction and clear guidance, you will learn critical steps to take in an overdose situation, how to call for emergency help, and how to provide support until medical professionals arrive. This training equips you with the skills to act quickly and potentially save a life, making a profound difference in your community.', '5481541a-60c6-4699-ac0d-12a968525faa') ON CONFLICT DO NOTHING;
INSERT INTO public."Course" VALUES ('C0006', 'TP0004', 'How to Help a Friend Who is Using (Without Getting Hurt)', 'Online', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'This course provides practical guidance on how to recognize the signs of substance use, initiate difficult conversations, and encourage professional help, all without compromising personal boundaries or safety. Learn about effective communication strategies, understanding addiction, the importance of self-care, and when and how to seek external support for both your friend and yourself. Empower yourself to be a compassionate and effective ally, protecting both your friend and your own future.', '5481541a-60c6-4699-ac0d-12a968525faa') ON CONFLICT DO NOTHING;
INSERT INTO public."Course" VALUES ('C0001', 'TP0001', 'Sober & Social: How to Have Fun Without Substances', 'Online', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'This course equips participants with practical strategies, confidence-building techniques, and fresh perspectives to navigate social situations, build genuine connections, and discover new avenues of enjoyment, all while maintaining sobriety. Learn to confidently decline, find fulfilling activities, and redefine what it means to have a good time on your own terms.', '5481541a-60c6-4699-ac0d-12a968525faa') ON CONFLICT DO NOTHING;
INSERT INTO public."Course" VALUES ('C0007', 'TP0001', 'Mindful Eating for a Balanced Life', 'Online', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Learn to cultivate a healthier relationship with food through mindful eating practices, improving both physical and emotional well-being.', '5481541a-60c6-4699-ac0d-12a968525faa') ON CONFLICT DO NOTHING;
INSERT INTO public."Course" VALUES ('C0008', 'TP0002', 'Understanding the Science of Addiction', 'Online', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Explore the neurological and psychological aspects of addiction to better understand its mechanisms and impact.', '5481541a-60c6-4699-ac0d-12a968525faa') ON CONFLICT DO NOTHING;
INSERT INTO public."Course" VALUES ('C0009', 'TP0003', 'Effective Communication for Conflict Resolution', 'Workshop', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Develop essential communication skills to navigate disagreements and foster healthier relationships.', '29e63063-d5fd-4d7a-9ea3-8521bdcd4559') ON CONFLICT DO NOTHING;
INSERT INTO public."Course" VALUES ('C0010', 'TP0004', 'Building Resilience: Coping with Adversity', 'Online', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Strategies and techniques to enhance personal resilience and bounce back from life''s challenges.', '66dc42c6-4f2f-4c2b-9415-e1c56b9bfe55') ON CONFLICT DO NOTHING;
INSERT INTO public."Course" VALUES ('C0011', 'TP0005', 'Introduction to Data Science with Python', 'Online', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'A beginner-friendly course on data science fundamentals using the Python programming language.', '5481541a-60c6-4699-ac0d-12a968525faa') ON CONFLICT DO NOTHING;
INSERT INTO public."Course" VALUES ('C0012', 'TP0001', 'Financial Literacy for Young Adults', 'Workshop', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Essential knowledge for managing personal finances, saving, and investing for a secure future.', '29e63063-d5fd-4d7a-9ea3-8521bdcd4559') ON CONFLICT DO NOTHING;
INSERT INTO public."Course" VALUES ('C0013', 'TP0002', 'Cybersecurity Basics for Everyday Users', 'Online', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Learn fundamental cybersecurity practices to protect your digital life from common threats.', '66dc42c6-4f2f-4c2b-9415-e1c56b9bfe55') ON CONFLICT DO NOTHING;
INSERT INTO public."Course" VALUES ('C0014', 'TP0003', 'Public Health Policy and Advocacy', 'Seminar', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Understand the role of policy in public health and how to advocate for healthier communities.', '5481541a-60c6-4699-ac0d-12a968525faa') ON CONFLICT DO NOTHING;
INSERT INTO public."Course" VALUES ('C0015', 'TP0004', 'Stress Management for Professionals', 'Workshop', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Practical techniques for managing workplace stress and maintaining work-life balance.', '29e63063-d5fd-4d7a-9ea3-8521bdcd4559') ON CONFLICT DO NOTHING;
INSERT INTO public."Course" VALUES ('C0016', 'TP0005', 'Introduction to Web Development (HTML, CSS, JS)', 'Online', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'A foundational course for building interactive and responsive websites.', '66dc42c6-4f2f-4c2b-9415-e1c56b9bfe55') ON CONFLICT DO NOTHING;
INSERT INTO public."Course" VALUES ('C0017', 'TP0001', 'Nutrition for Peak Performance', 'Online', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Optimize your diet for improved energy, focus, and overall physical performance.', '5481541a-60c6-4699-ac0d-12a968525faa') ON CONFLICT DO NOTHING;
INSERT INTO public."Course" VALUES ('C0018', 'TP0002', 'Parenting in the Digital Age', 'Seminar', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Guidance for parents on navigating screen time, online safety, and digital well-being for children.', '29e63063-d5fd-4d7a-9ea3-8521bdcd4559') ON CONFLICT DO NOTHING;
INSERT INTO public."Course" VALUES ('C0019', 'TP0003', 'Creative Problem Solving Techniques', 'Workshop', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Learn innovative approaches to solve complex problems in various aspects of life.', '66dc42c6-4f2f-4c2b-9415-e1c56b9bfe55') ON CONFLICT DO NOTHING;
INSERT INTO public."Course" VALUES ('C0020', 'TP0004', 'Mind-Body Connection: Yoga and Wellness', 'In-Person', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Explore the benefits of yoga for mental clarity, physical strength, and emotional balance.', '5481541a-60c6-4699-ac0d-12a968525faa') ON CONFLICT DO NOTHING;
INSERT INTO public."Course" VALUES ('C0021', 'TP0005', 'Basics of Graphic Design with Canva', 'Online', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'A practical course for creating stunning visuals using the popular Canva platform.', '29e63063-d5fd-4d7a-9ea3-8521bdcd4559') ON CONFLICT DO NOTHING;
INSERT INTO public."Course" VALUES ('C0022', 'TP0001', 'Sustainable Living: Eco-Friendly Practices', 'Online', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Discover practical ways to reduce your environmental footprint and live more sustainably.', '66dc42c6-4f2f-4c2b-9415-e1c56b9bfe55') ON CONFLICT DO NOTHING;
INSERT INTO public."Course" VALUES ('C0023', 'TP0002', 'Understanding Social Media Impact on Youth', 'Seminar', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Examine the psychological and social effects of social media on young individuals.', '5481541a-60c6-4699-ac0d-12a968525faa') ON CONFLICT DO NOTHING;
INSERT INTO public."Course" VALUES ('C0024', 'TP0003', 'Introduction to Project Management', 'Online', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Learn the fundamental principles and tools for effective project planning and execution.', '29e63063-d5fd-4d7a-9ea3-8521bdcd4559') ON CONFLICT DO NOTHING;
INSERT INTO public."Course" VALUES ('C0025', 'TP0004', 'Emotional Intelligence for Personal Growth', 'Workshop', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Develop your emotional intelligence to improve self-awareness, empathy, and relationships.', '66dc42c6-4f2f-4c2b-9415-e1c56b9bfe55') ON CONFLICT DO NOTHING;
INSERT INTO public."Course" VALUES ('C0026', 'TP0005', 'Public Speaking for Beginners', 'Workshop', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Overcome public speaking anxiety and deliver engaging presentations with confidence.', '5481541a-60c6-4699-ac0d-12a968525faa') ON CONFLICT DO NOTHING;
INSERT INTO public."Course" VALUES ('C0027', 'TP0001', 'Healthy Budgeting and Financial Planning', 'Online', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Learn practical strategies for budgeting, saving, and planning for your financial future.', '29e63063-d5fd-4d7a-9ea3-8521bdcd4559') ON CONFLICT DO NOTHING;
INSERT INTO public."Course" VALUES ('C0028', 'TP0002', 'Understanding Peer Pressure and Influence', 'Seminar', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Equip yourself with strategies to resist negative peer pressure and make independent choices.', '66dc42c6-4f2f-4c2b-9415-e1c56b9bfe55') ON CONFLICT DO NOTHING;
INSERT INTO public."Course" VALUES ('C0029', 'TP0003', 'Introduction to Digital Marketing', 'Online', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Gain foundational knowledge in digital marketing strategies and tools.', '5481541a-60c6-4699-ac0d-12a968525faa') ON CONFLICT DO NOTHING;
INSERT INTO public."Course" VALUES ('C0030', 'TP0004', 'Mindfulness for Daily Living', 'Workshop', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Incorporate mindfulness practices into your daily routine for reduced stress and increased well-being.', '29e63063-d5fd-4d7a-9ea3-8521bdcd4559') ON CONFLICT DO NOTHING;
INSERT INTO public."Course" VALUES ('C0031', 'TP0005', 'Creative Writing: From Idea to Story', 'Online', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Develop your creative writing skills and learn how to craft compelling narratives.', '66dc42c6-4f2f-4c2b-9415-e1c56b9bfe55') ON CONFLICT DO NOTHING;
INSERT INTO public."Course" VALUES ('C0032', 'TP0001', 'Time Management and Productivity Hacks', 'Workshop', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Learn effective strategies to manage your time, boost productivity, and achieve your goals.', '5481541a-60c6-4699-ac0d-12a968525faa') ON CONFLICT DO NOTHING;
INSERT INTO public."Course" VALUES ('C0033', 'TP0002', 'Understanding and Preventing Online Scams', 'Online', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Educate yourself on common online scams and how to protect yourself from cyber fraud.', '29e63063-d5fd-4d7a-9ea3-8521bdcd4559') ON CONFLICT DO NOTHING;
INSERT INTO public."Course" VALUES ('C0034', 'TP0003', 'Introduction to Artificial Intelligence', 'Online', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'A foundational course exploring the concepts and applications of artificial intelligence.', '66dc42c6-4f2f-4c2b-9415-e1c56b9bfe55') ON CONFLICT DO NOTHING;
INSERT INTO public."Course" VALUES ('C0035', 'TP0004', 'Building Healthy Habits for Life', 'Workshop', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Learn how to establish and maintain positive habits for long-term health and well-being.', '5481541a-60c6-4699-ac0d-12a968525faa') ON CONFLICT DO NOTHING;
INSERT INTO public."Course" VALUES ('C0036', 'TP0005', 'Photography Basics: Capturing Great Shots', 'Online', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'An introductory course to photography, covering camera settings, composition, and lighting.', '29e63063-d5fd-4d7a-9ea3-8521bdcd4559') ON CONFLICT DO NOTHING;
INSERT INTO public."Course" VALUES ('C0037', 'TP0001', 'Conflict Resolution for Families', 'Workshop', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Strategies for resolving conflicts peacefully within family dynamics.', '66dc42c6-4f2f-4c2b-9415-e1c56b9bfe55') ON CONFLICT DO NOTHING;
INSERT INTO public."Course" VALUES ('C0038', 'TP0002', 'Understanding Global Climate Change', 'Online', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Explore the causes, impacts, and potential solutions to global climate change.', '5481541a-60c6-4699-ac0d-12a968525faa') ON CONFLICT DO NOTHING;
INSERT INTO public."Course" VALUES ('C0039', 'TP0003', 'Introduction to Public Speaking', 'Workshop', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Build confidence and skills for effective public speaking.', '29e63063-d5fd-4d7a-9ea3-8521bdcd4559') ON CONFLICT DO NOTHING;
INSERT INTO public."Course" VALUES ('C0040', 'TP0004', 'Managing Anxiety and Panic Attacks', 'Online', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Learn practical techniques and coping strategies for anxiety and panic.', '66dc42c6-4f2f-4c2b-9415-e1c56b9bfe55') ON CONFLICT DO NOTHING;
INSERT INTO public."Course" VALUES ('C0041', 'TP0005', 'Introduction to Mobile App Development', 'Online', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'A beginner''s guide to developing mobile applications for various platforms.', '5481541a-60c6-4699-ac0d-12a968525faa') ON CONFLICT DO NOTHING;
INSERT INTO public."Course" VALUES ('C0042', 'TP0001', 'Healthy Eating on a Budget', 'Workshop', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Discover how to prepare nutritious meals without breaking the bank.', '29e63063-d5fd-4d7a-9ea3-8521bdcd4559') ON CONFLICT DO NOTHING;
INSERT INTO public."Course" VALUES ('C0043', 'TP0002', 'Understanding Media Literacy', 'Online', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Develop critical thinking skills to analyze and evaluate media messages.', '66dc42c6-4f2f-4c2b-9415-e1c56b9bfe55') ON CONFLICT DO NOTHING;
INSERT INTO public."Course" VALUES ('C0044', 'TP0003', 'Introduction to Cybersecurity Careers', 'Seminar', '2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'Explore career opportunities and pathways in the field of cybersecurity.', '5481541a-60c6-4699-ac0d-12a968525faa') ON CONFLICT DO NOTHING;
INSERT INTO public."Course" VALUES ('C0045', 'TP0004', 'Building Positive Self-Esteem', 'Workshop', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'Strategies and exercises to foster a healthy and positive self-image.', '29e63063-d5fd-4d7a-9ea3-8521bdcd4559') ON CONFLICT DO NOTHING;


--
-- TOC entry 4967 (class 0 OID 17496)
-- Dependencies: 227
-- Data for Name: CourseEnroll; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."CourseEnroll" VALUES ('CE0012', 'c6e1b498-7d6d-4da8-9f6a-407ff21e98e4', 'C0003', 'Enrolled', '2025-06-27', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."CourseEnroll" VALUES ('CE0014', 'c6e1b498-7d6d-4da8-9f6a-407ff21e98e4', 'C0004', 'Enrolled', '2025-06-27', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."CourseEnroll" VALUES ('CE0015', 'c6e1b498-7d6d-4da8-9f6a-407ff21e98e4', 'C0005', 'Completed', '2025-06-27', '2025-07-01') ON CONFLICT DO NOTHING;
INSERT INTO public."CourseEnroll" VALUES ('CE0013', 'c6e1b498-7d6d-4da8-9f6a-407ff21e98e4', 'C0006', 'Completed', '2025-06-27', '2025-07-01') ON CONFLICT DO NOTHING;
INSERT INTO public."CourseEnroll" VALUES ('CE0016', 'c6e1b498-7d6d-4da8-9f6a-407ff21e98e4', 'C0001', 'Completed', '2025-06-30', '2025-07-03') ON CONFLICT DO NOTHING;
INSERT INTO public."CourseEnroll" VALUES ('CE0019', 'c96d8d61-93dd-4637-9f21-a9df16162890', 'C0002', 'Enrolled', '2025-07-04', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."CourseEnroll" VALUES ('CE0020', 'c96d8d61-93dd-4637-9f21-a9df16162890', 'C0001', 'Enrolled', '2025-07-04', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."CourseEnroll" VALUES ('CE0018', 'c6e1b498-7d6d-4da8-9f6a-407ff21e98e4', 'C0002', 'Completed', '2025-07-04', '2025-07-05') ON CONFLICT DO NOTHING;
INSERT INTO public."CourseEnroll" VALUES ('CE0021', '084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'C0003', 'Enrolled', '2025-07-14', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."CourseEnroll" VALUES ('CE0022', 'ef9a96c7-df9a-4509-9700-f651328d9f6e', 'C0003', 'Completed', '2025-07-16', '2025-07-16') ON CONFLICT DO NOTHING;
INSERT INTO public."CourseEnroll" VALUES ('CE0002', 'd65924da-5a4f-49a2-adb5-11b18dc22ca9', 'C0005', 'Enrolled', '2025-06-20', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."CourseEnroll" VALUES ('CE0003', 'd65924da-5a4f-49a2-adb5-11b18dc22ca9', 'C0001', 'Enrolled', '2025-06-20', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."CourseEnroll" VALUES ('CE0023', 'c6e1b498-7d6d-4da8-9f6a-407ff21e98e4', 'C0011', 'Completed', '2025-07-23', '2025-07-23') ON CONFLICT DO NOTHING;


--
-- TOC entry 4968 (class 0 OID 17501)
-- Dependencies: 228
-- Data for Name: CourseTopic; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."CourseTopic" VALUES ('TP0001', 'Social Life') ON CONFLICT DO NOTHING;
INSERT INTO public."CourseTopic" VALUES ('TP0002', 'Vaping & Social Media') ON CONFLICT DO NOTHING;
INSERT INTO public."CourseTopic" VALUES ('TP0003', 'Education') ON CONFLICT DO NOTHING;
INSERT INTO public."CourseTopic" VALUES ('TP0004', 'Mental Health') ON CONFLICT DO NOTHING;
INSERT INTO public."CourseTopic" VALUES ('TP0005', 'Skills & Visions') ON CONFLICT DO NOTHING;


--
-- TOC entry 4969 (class 0 OID 17506)
-- Dependencies: 229
-- Data for Name: Role; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Role" VALUES ('AD', 'Admin') ON CONFLICT DO NOTHING;
INSERT INTO public."Role" VALUES ('MA', 'Manager') ON CONFLICT DO NOTHING;
INSERT INTO public."Role" VALUES ('ST', 'Staff') ON CONFLICT DO NOTHING;
INSERT INTO public."Role" VALUES ('CO', 'Consultant') ON CONFLICT DO NOTHING;
INSERT INTO public."Role" VALUES ('ME', 'Member') ON CONFLICT DO NOTHING;


--
-- TOC entry 4970 (class 0 OID 17511)
-- Dependencies: 230
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."User" VALUES ('402d96ef-a9c1-469c-a55f-1b17fb4d79c4', 'ME', 'seqs', '2025-06-06', '0930293212', 'khoitestmember4@gmail.com', '$2a$11$YN3xy4MyAHQiSdhlGkXk0OBBc5T/.XI3PkDHYFcXEIR3Rn88tFaOm', '2025-07-25 13:07:59.626031+07', 'ZZE1NPWUTAVg6B1hGLRmT3m56EyHXm3BnGWNOrofrg0=', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('29e63063-d5fd-4d7a-9ea3-8521bdcd4559', 'CO', 'Martin', '2025-06-13', '12345678', 'Martin@consultant.com', '$2a$11$o.V00fzag6kf5TtnR2kTvONCCtQH2l0ThM/6V9qZO8jR2c9gW8UAa', '2025-07-23 21:29:43.995368+07', 'ebjcX+detcSjMkK9gWA0sK9QNGIHR6x6agD34gnl3qw=', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('df8d14c0-f6cc-4c6b-98cd-175b28bc57eb', 'ME', 'noidea', '2025-06-13', '0930293212', 'khoitestmember3@gmail.com', '$2a$11$lo0o09VVekHAMSCVswEFW.Tiq/uWhyEv3P8rP552Qmy/61ML7xDm.', '2025-07-25 13:22:34.954371+07', 'qYyujZRoTpjWjaUFyvDQUBjBEyf8jsZuT27/pT3dAgk=', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('c9ce6277-9851-4d66-9dbe-b3243728d8c6', 'ME', 'jane212', '2025-06-12', '0930293212', 'khoitestmember5@gmail.com', '$2a$11$F5YnhDs1wkQGuhP2EXs9jeJx9vN7EkLbkGDxnaUBfQHooUSudiTFW', '2025-07-25 13:30:36.605909+07', 'YT4eERVSOqWhL2KvNbAvotIfkT9wLz1vOJ9MREZ2VAI=', 'Qzr1l3oRURc9PhKdbIezKpbKtT9iAnMHQAaNRLvUcV4=', '2025-06-21 16:05:56.159602+07') ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('d65924da-5a4f-49a2-adb5-11b18dc22ca9', 'ME', 'James', '2025-06-28', '3748929', 'James@gmail.com', '$2a$11$cyZEohrq//pKTAPifsBngelpH.jipD5/da8T3fUkMwXSKoOOcmeSW', '2025-06-27 13:40:19.667367+07', 'ghZ2BnJhRcx02VIHk+zGd44OU1M4yWZmgryuiOuVaYY=', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('ef9a96c7-df9a-4509-9700-f651328d9f6e', 'ME', 'David Member', '2000-05-10', '4443332222', 'david.m@example.com', '$2a$11$15ewMWHqbeiqfdkpnbGXuOnbv6ajvaPVoFHqs6RrL4FBM67FvkGKG', '2025-07-25 13:29:15.92215+07', 'iCvQhH5ydCY6faefie/r2spXKIy+Ur9uCxpDyFar7yQ=', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('084e1e8c-2191-42e7-a7f9-f1132d6a5628', 'ST', 'Bob Staff', '1985-03-20', '1112', 'bob.staff@example.com', '$2a$11$KVuzJprACgn1R96D9qnFlO1c0XmjI5Cv7aXpBvPImQKJH.lg5CjBi', '2025-07-23 11:31:41.752209+07', 'bV5KuacjZatOpfbIRQLMScK5EELQ5SVR2//vVyWg6iQ=', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('1285ff99-fef4-4d76-9a00-5232c88136d7', 'ME', 'michaelbrown ', '2025-07-15', '4651345642', 'michaelbrown@gmail.com', '$2a$11$m3NkhBpOGZJKZczn5lM1buLPbiFOdRqDWThj06xsU7s74F/Y.z17i', '2025-07-22 13:46:34.455047+07', '4/r+D7exB1YjmoHLEvMfLqsWc+yn2gtMP2yqUlptfK0=', 'Qzr1l3oRURc9PhKdbIezKpbKtT9iAnMHQAaNRLvUcV4=', '2025-06-21 16:05:56.159602+07') ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('54d1c19f-10ca-41a3-8bf3-313ac7c628b7', 'ME', 'sadw', '2025-07-19', '', 'alice.smith01@example.com', '$2a$11$rbUBd3CGZ7K9DnaAZt445e0K9UAR3OweSoL3Ffz2uugVQyMbyjhI2', '2025-07-08 12:34:46.705736+07', 'zTe1E+04b2iFDmxaBN+KP6XyShB+gBkHqxlKPrQc++0=', 'Qzr1l3oRURc9PhKdbIezKpbKtT9iAnMHQAaNRLvUcV4=', '2025-06-21 16:05:56.159602+07') ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('32928af7-159a-4574-93dc-39c762e6946a', 'ME', 'Hello', '2025-06-30', '', 'hello@example.com', '$2a$11$IiD7WCRJ7r9N64eQQLjbmOPaLVAR6JN2IthmaCAcn2OG50vt.Qm42', '2025-07-24 10:18:54.155085+07', 'uQ5eierNDiu4aNhcBLrkkrXpQDxpomhb4Gn3j7NHkXc=', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('97575acd-bfb2-4647-857b-8762ed15bfc1', 'ME', 'jane', '2025-06-19', '0930293212', 'khoitestmember2@gmail.com', '$2a$11$G2u2ZUq7z/zfnF191pN/5O0RKvlbEsjZhWjJUYRVRAzx.r69ujTzi', '2025-07-25 13:23:45.401046+07', 'P1/OE4r2AFYdnJKMNNT3I16S2W7oWvE7pt5jzOtkrK4=', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('972d149d-0d02-4a3f-b195-5704592ffda4', 'ME', 'khoi1', '2025-06-05', '0930293212', 'khoitestmember1@gmail.com', '$2a$11$vObUa4BHs2PeYzU2oc7KFeuTAjCeOF7pLsTw8uWGpvmEnJj6D1j1S', '2025-07-25 13:24:32.150435+07', 'a2S6MjFCuYWJ6MmazozL8VSI9D3e0YVf6/4tw/vl2rE=', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('66dc42c6-4f2f-4c2b-9415-e1c56b9bfe55', 'CO', 'khoi', '2025-06-12', '0930293212', 'khoiconsultant1@gmail.com', '$2a$11$H6q0K8h5RpKEQynfvsd/JeX0ZB0GquAjfC8TC.AuEpFU3Yidp2eP.', '2025-07-25 21:31:02.192412+07', '7V6VuZ8to/2dDKIilS7ri8DJy8C5Coa4oeo4tK75w1c=', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('51d54b1f-0951-4b9e-9ec7-d3c23d3922b8', 'ME', 'khoipham27', '2025-06-11', '0903123132', 'khoi@gmail.com', '$2a$11$Fij0m235VszKGyLD0jMiYeXKsXvUd0xqKOVodzACS6nSvLexG/6nu', '2025-07-04 12:28:05.920892+07', 'KKJIEF5Hu3ART00MN2hLLO5e7c683dcOzGwQCNT6uf4=', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('2a5185c4-6cb0-415c-b4a1-2cb4be5e406c', 'ST', 'John Staff', '1992-06-18', '3332221111', 'john.staff@example.com', '$2a$11$4nZWxicnDqm1sLsv4/GjeeuH6gb2Ve9cIA2FVZIL6d//XMiWyIb7G', NULL, NULL, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('196f3a51-faed-4740-b017-24ec41e43e50', 'ME', 'hehe', '2025-07-03', '0930293212', 'khoitestmember7@gmail.com', '$2a$11$xowbiLOjJNj2ZJL3C5UQDuqwUVVkc6OJC6yIkGEzK0m9mCATVwJ3i', '2025-07-11 16:43:58.017258+07', 'DXJbRue62po3en2V/upzuLHqeeu2hwH7TIEeB6Ski8I=', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('258e30ed-25c2-4565-8f5e-653b152d5dfc', 'AD', 'test3', '2025-06-27', NULL, 'test3@gmail.com', '$2a$11$Bz8SMOgQQZiogb0n3DPKx./7whN9MjFJayAR1xaPROjZ6E6M79hiG', '2025-07-04 15:59:28.422885+07', '4PciPj23pFf/TGiUIuVLidYfw7CcGWqRodpS2kOUc6o=', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('dc9f3921-39fb-48a9-8c9b-fbaa4946d8db', 'ME', 'hieu', '2025-06-20', '0930293212', 'bluekeynet@gmail.com', '$2a$11$I1GHTi2S7mDg0gXK6i0YouzTaq/6g3Gs2hG3sSwnBfPbqKgkdUEbC', '2025-07-06 23:25:15.407692+07', 'N/HtgqU07FlHGJoRQPmB5OqhiVRfgBgritGJUFpxS80=', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('3c6146fb-4900-4ee4-ae48-08fc822fb7d9', 'CO', 'Charles', '2025-06-13', '12345678', 'Charles@gmail.com', '$2a$11$yq8CpzHWNKSpCf5WXglnq.JohRH8Z1Du5Mcdzm6FKtC15.6u4L8w2', '2025-07-02 18:57:10.968116+07', 'JsdS/0LVvnCD9CnaS5VzykYSa7GB+B+A6/2t0qUBt0A=', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('546e6b5e-ed8a-44b0-99bd-451c10097a20', 'ME', 'phat', '2025-06-26', '0930293212', 'luuvinhphat112005@gmail.com', '$2a$11$Jo0rNtxucANTVWJvV/0Tp.fqXIwV73eDVXSs6sVPaVupdch9/I286', '2025-07-06 23:46:45.503183+07', 'zEtT4m069/l57TcahXliaoDo/tuNGclNfjKSAGwBHZc=', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('934220d0-64a6-4a77-8cf4-5a8ba5d2e8ce', 'ME', 'mei', '2025-05-28', '2136443249', 'met@gm.com', '$2a$11$oTbtjm5wHfaGFqLk2anScu5bL/3329uARQRnsuYZqwBEijoqYVQOO', NULL, NULL, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('29c6215a-c5e1-4992-ad18-c8d41cd1c2cf', 'ME', 'test2', '2025-06-27', NULL, 'test2@gmail.com', '$2a$11$po1J6X6MprPQljHKBYZ0juj2ISsLlta8otM10o/n7IZWSaM.n6tK.', '2025-07-04 15:38:37.353951+07', 'kP3C6iL2eA3fJkXp73LE/+rDZwkZg/VMHbkRaUpyYkQ=', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('e74fb36d-8006-493c-b704-b24933c920f4', 'ME', 'test1', '2025-06-27', NULL, 'test@gmail.com', '$2a$11$hZLTfShTTbY5PhS137H3lOxPUePj4DwN1tCu7zfXu/weB2T2qvQEu', '2025-07-04 14:09:39.5103+07', 'and/44DFg0Pknek8K/SW7mqVxIQJsWkhzmwrxfPaiag=', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('24a12f28-dd94-4eeb-a7d5-7a625f0edd70', 'ME', 'borick', '2025-06-19', '0930293212', 'borickmichile@gmail.com', '$2a$11$o6HRC1l3TG0jt.f/A.iKMegZrEm88vhVzupgNUuoqw310JQ5St9QW', '2025-07-06 15:38:11.913364+07', 'wWsutVNZcw3hB5NCsjX5YWidF0HzkTak0NLcqvQgsvE=', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('22c6a195-1328-4ac1-b667-d92e068dddb5', 'CO', 'sdg', '2025-07-07', '2342345436346346', 'sdf@gmail.com', '$2a$11$iC6x6ZMbTTVSOntcf.jFZuZ3g06DYc4gxUbieV/Qre1enHO65b81G', NULL, NULL, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('83b95e1e-de81-436b-88c3-482e2a50b218', 'AD', 'khoipham272312', '2025-06-30', '0930293212', 'khoitestmember6@gmail.com', '$2a$11$HQQU/RuS6xca.z5gXmv4IeQdM6JAX.ka1mloeILI0gEel5VjeHU2q', '2025-07-11 16:43:37.119531+07', 'xq5wvqYxIDCwNec8Fp2ISdQlw8nVrl6hJq0Ck/Awmg0=', 'Qzr1l3oRURc9PhKdbIezKpbKtT9iAnMHQAaNRLvUcV4=', '2025-06-21 16:05:56.159602+07') ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('ae5f12d9-759e-47ad-8b7b-1ad64b27a3c4', 'ME', 'hehe132', '2025-06-25', '0930293212', 'khoitestmember8@gmail.com', '$2a$11$isIaQDep4.str09zYTGr5upRTeZNfCmal.TDhZkBQf6WqdYsAI.jm', '2025-07-11 00:37:24.654551+07', '9sdK39ZGIJb4m5+8H/bZo6/5Mm4gQvDofppfHQLV5Sw=', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('ec72cf46-1252-48bd-adfc-0623d5479716', 'ME', 'johnsmith ', '2014-06-13', '1234567812', 'johnsmith@gmail.com', '$2a$11$Fwm6nj/0DU.XPQw2ymi62OO2mFkakvdPPKkfeL8Z5nVvQVG/DWIzi', NULL, NULL, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('1dea15d0-f215-42ce-91ae-9e0682011bfc', 'ME', 'emilyjones ', '2025-07-17', '1234567456', 'emilyjones@gmail.com', '$2a$11$g43qH9rOTBa928u70y6nA.ZGKswoQ4wJKAgQc.L0ePEbNYDlJl7oC', NULL, NULL, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('7959c159-935c-49e1-8fb1-c679b4b4cae8', 'ME', 'olivia2023 ', '2025-07-15', '1234567478', 'olivia2023@gmail.com', '$2a$11$2dLOQUGBz8uSqz6uHXUa4eig5AbHOFPeIYpLqPYFl.Fp59KhiVCUm', NULL, NULL, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('ed022964-c087-48d9-a1aa-0adf27deeec2', 'ME', 'jacob99', '2025-07-15', '7892439875', 'jacob99@gmail.com', '$2a$11$Q5sQ3FyH1UdUfTk9M3.gaO5lM5.1AwA8sXhiB.4MQGhQn86zGBmi2', NULL, NULL, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('b2ff979a-ce1f-4391-a6ab-c2d847b3106a', 'ME', 'ava42 ', '2025-07-15', '789549224389', 'ava42@gmail.com', '$2a$11$QwajY/aRx8MPhqh6/LzW7uGANU.A7S8EfbaWy596KxwYp/GQ5P4fi', NULL, NULL, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('a711d77b-2485-4213-9293-38f39f6834e9', 'ME', 'noah55 ', '2025-07-15', '5635124325', 'noah55@gmail.com', '$2a$11$KXKnyvx6EfVPY.YnW2XVguWnAgQLXyF/6BLHioWxGN8G.XyEGseIu', NULL, NULL, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('f12374fd-8174-4263-9334-e960a2f84e5a', 'CO', 'anh khoa', '2025-06-19', '0930293212', 'phamanhkh4@gmail.com', '$2a$11$FW.kJUFstAaXcOipg5hAsuOQPIUF5Sc2ueSHOJgXF58rQnLskQShm', '2025-07-30 22:17:48.854207+07', 'YGPW2MrF8vJAWA94587GNSfv+Zrw4ro1B/pNx68/7w4=', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('0641d4df-e065-4376-a80f-a72891050a03', 'ME', 'mia2024 ', '2025-07-15', '13235454326', 'mia2024@gmail.com', '$2a$11$OsZp/IUrBsvWGFGP3o1YPOwsFdkliAVRD5Y6Ev2cXpItW1LacJwqW', NULL, NULL, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('06ee7de4-1e07-45c3-bc1d-f2fd2c1d4981', 'ME', 'ethan007 ', '2025-07-15', '1322436789', 'ethan007@gmail.com', '$2a$11$kfmRmHYCe1nA4TbouVQrD.fRGxeBDA6G1EQ1u6txIE2UxN3H5Gl.y', NULL, NULL, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('e5e1552e-8b1e-473d-841f-bdf47c2eb9ef', 'ME', 'chloe101 ', '2025-07-15', '2312357987', 'chloe101@gmail.com', '$2a$11$Fi6q.3rN8.GoNzCfHocZcOQywzOixjR6BtHzq0RQIOtSfANayHGIq', NULL, NULL, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('2b58e004-0044-4656-9259-9e3ef4b92a6d', 'ME', 'james.wilson', '2025-07-15', '243425452436', 'james.wilson@gmail.com', '$2a$11$WHGr47uPZE1oxEvEp/nEj.q.uiAekvT3nny.zfNciUfkth8Tfb3EC', NULL, NULL, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('7948d548-1032-4760-a56f-0cb4fc323a96', 'ME', 'emma.johnson', '2025-07-15', '35213234456', 'emma.johnson@gmail.com', '$2a$11$bmlIDIXqK0NqPgDHQQ/BN.HaVo/OSDYLe2uMcjyWPdLamhoFLQ1Qe', NULL, NULL, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('6dfdc959-14ef-40c3-b568-707e7ee1fa1f', 'ME', 'daniel.miller ', '2025-07-15', '12432123655', 'daniel.miller@gmail.com', '$2a$11$tcjWnqlSW4UbZSiQ3B6caOG083SR1x/xXH7eNvl5lo2FnCoV/8h8a', NULL, NULL, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('cadf04a3-d807-4c9b-937b-aef652eecd5c', 'ME', 'lily.thompson', '2025-07-15', '14364524334', 'lily.thompson@gmail.com', '$2a$11$Uv/qLjoKTxU/n7u7H73byuY6GTme02tJOStUM0tAC5N4fwmwPlI5.', NULL, NULL, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('f78c3f8d-aeab-42bc-99b0-294614811e87', 'ME', 'henry.davis', '2025-07-15', '1231325643', 'henry.davis@gmail.com', '$2a$11$fCzeDosH9Oof1NIvC6sZPuxGIHaWdtG/EsEKssOfjjKPGNRqvW1B2', NULL, NULL, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('fa90abbc-8cbe-4537-8144-574f6362386e', 'ME', 'ava.martinez', '2025-07-15', '12425312235', 'ava.martinez@gmail.com', '$2a$11$zdiQ/4xL44A.QBNCC/LFbed1ADh6sX0sHxQ1MghOuOLosC3gAgsB.', NULL, NULL, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('ed1dac81-96b1-4793-ac54-b82121d34700', 'ME', 'logan.robinson ', '2025-07-15', '213243321253', 'logan.robinson@gmail.com', '$2a$11$sBucqsExMTvQdM/6ECXOr.aucB42sspLqcMh.0VBotU7GtCIL.dLO', NULL, NULL, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('0eb226be-b42f-41c0-b7e8-03b9f58e225b', 'ME', 'zoey.walker', '2025-07-15', '2523125346352', 'zoey.walker@gmail.com', '$2a$11$tHa1HeBmGHZA4mzopWdAd.i3aFG2hhM/4yJ0RFzj5nmGX/w2oGqSq', NULL, NULL, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('85ea10e2-e7de-4f18-a37c-6f18dcfdf0ac', 'ME', 'jack.harris', '2025-07-15', '23412434253', 'jack.harris@gmail.com', '$2a$11$toeyESy.YCpHYq546SXGw.vnCtFV85EL7Oxca0CCTr1tD2Y1V30ge', NULL, NULL, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('74c9560f-8226-4ff2-80b7-d77049d76ecf', 'ME', 'ella.moore', '2025-07-15', '12323565253', 'ella.moore@gmail.com', '$2a$11$GThmU41YKg8.Q8tMH49N2ejD7Zhms2UYTo0SIbX6XDqfs7nD7tIh6', NULL, NULL, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('7ca29d81-d09b-4e9d-b75c-cf6a10cffe8f', 'ME', 'max_parker', '2025-07-15', '42546367984', 'max_parker@gmail.com', '$2a$11$0ZFOfsgdwtZ60TGG6pbpfel5fCIFBlIHNvpOSRUQlWr4iB8iuDIJm', NULL, NULL, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('f8606553-9a2e-4072-8c95-78835e35f105', 'ME', 'hannah_scott', '2025-07-15', '2543323564', 'hannah_scott@gmail.com', '$2a$11$Y/UiBYx8i8ReeQVbiBtOW.Dk7zid4fpOzy/HaMwnHzHPdh9Ng5.4.', NULL, NULL, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('100a1019-ed31-4543-a35c-27854a4c1487', 'ME', 'liam_green', '2025-07-15', '253321356234', 'liam_green@gmail.com', '$2a$11$p0cVOxWOIaZt5N.HsRdQSOo0CXK0yLoFjSiXfvGnnWCvj3uXAx8ZW', NULL, NULL, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('9040bd93-be27-480e-af56-24c5a148b0c7', 'ME', 'scarlett_adams', '2025-07-15', '124523366334', 'scarlett_adams@gmail.com', '$2a$11$vqC2oaeYIWqAaZ.XZN.Pve2vDZHFk8hr0dZK5H49vDS.Qh.5FRacm', NULL, NULL, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('f792b36b-1442-4e90-a54e-9b88aeefa565', 'ME', 'owen_king', '2025-07-15', '1245436564646', 'owen_king@gmail.com', '$2a$11$aojBH6yV49xqEUFQaeELg.ew7b3K9cqssv.mxCOEvW/VkZajRoLMK', NULL, NULL, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('989e8855-9904-424b-9c13-bef48622be92', 'ME', 'amelia_baker ', '2025-07-15', '1232453436', 'amelia_baker@gmail.com', '$2a$11$BdgKV5NWCCqpD4UI1wczDeQuThmikuRlhzMHvBimhqAtCNNhs6Iau', NULL, NULL, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('bb8498b0-f2c0-4d09-af89-2aba825c40ba', 'ME', 'lucas_rivera', '2025-07-15', '12323234978', 'lucas_rivera@gmail.com', '$2a$11$lnaCk6/cNJpKVWvDOjk9hO3mQ/8BKokF9EY9oX1astQa3e1.4dice', NULL, NULL, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('510c22e5-0d75-428c-ae7f-a3902ca56031', 'ME', 'alex123 ', '2025-08-01', '17938289743', 'alex123@gmail.com', '$2a$11$sjfL85j28oUPcCDrDzTTNuwRpZMPkIvrdQbjG5pZrhpwrCK8TVdj.', '2025-07-24 09:56:02.788002+07', 'Zpa7FMwpryXXVlJOpH8XCxAzMcbKj4ObbNwn9E4IYfk=', 'Qzr1l3oRURc9PhKdbIezKpbKtT9iAnMHQAaNRLvUcV4=', '2025-06-21 16:05:56.159602+07') ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('b10a5a95-4ff1-4016-9030-066f0d22da00', 'ME', 'ryan7890 ', '2025-04-18', '7892456340', 'ryan7890@gmail.com', '$2a$11$TV3bmcNxuwsNrDH1SPaKB.vgcJ6dkZKqJ8RL2vVeot57f9zXTQczG', '2025-07-22 13:46:34.455047+07', '4/r+D7exB1YjmoHLEvMfLqsWc+yn2gtMP2yqUlptfK0=', 'Qzr1l3oRURc9PhKdbIezKpbKtT9iAnMHQAaNRLvUcV4=', '2025-06-21 16:05:56.159602+07') ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('290630b1-144d-45d3-9a22-c7dffa79befa', 'ME', 'williamclark ', '2025-07-29', '12345668759', 'williamclark@gmail.com', '$2a$11$9KqQDNUfYm30CN0MVOgB6e4lX4vGu2L3Wvmx/6Nv6qt/OfjDweSeW', '2025-07-22 13:46:34.455047+07', '4/r+D7exB1YjmoHLEvMfLqsWc+yn2gtMP2yqUlptfK0=', 'Qzr1l3oRURc9PhKdbIezKpbKtT9iAnMHQAaNRLvUcV4=', '2025-06-21 16:05:56.159602+07') ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('73d72409-84df-487f-b3f4-3b0f6ddddf3f', 'ME', 'jenniferwhite', '2025-07-23', '1234566478', 'jenniferwhite@gmail.com', '$2a$11$iO8W9MmGgaAd0OKsT76C0.L.K6n4JMNQ4iSvFVAp5MySNRCwRLB5y', '2025-07-22 13:46:34.455047+07', '4/r+D7exB1YjmoHLEvMfLqsWc+yn2gtMP2yqUlptfK0=', 'Qzr1l3oRURc9PhKdbIezKpbKtT9iAnMHQAaNRLvUcV4=', '2025-06-21 16:05:56.159602+07') ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('a7f16fdb-7e05-4519-b9b5-54ff9f32a691', 'ME', 'lisamartin ', '2025-07-17', '1234563469', 'lisamartin@gmail.com', '$2a$11$PiSTlfhcAXOFRL.f9ev4MewfOLjehJ8HP85XSO6Giy0f5c1ZQgxBW', '2025-07-22 13:46:34.455047+07', '4/r+D7exB1YjmoHLEvMfLqsWc+yn2gtMP2yqUlptfK0=', 'Qzr1l3oRURc9PhKdbIezKpbKtT9iAnMHQAaNRLvUcV4=', '2025-06-21 16:05:56.159602+07') ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('2e6db162-940c-4a61-91fe-30ba4e4bf68f', 'ME', 'robertgarcia ', '2025-07-19', '1234545687', 'robertgarcia@gmail.com', '$2a$11$vBMoq7xyzp2oUHIXMr1jkeJZzi9AkSLzv.L14fzPFxqi0rk3.L1mG', '2025-07-22 13:46:34.455047+07', '4/r+D7exB1YjmoHLEvMfLqsWc+yn2gtMP2yqUlptfK0=', 'Qzr1l3oRURc9PhKdbIezKpbKtT9iAnMHQAaNRLvUcV4=', '2025-06-21 16:05:56.159602+07') ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('fb0455bd-10c2-49f8-928e-ada2578ec824', 'ME', 'sophia456 ', '2025-06-13', '45136789432', 'sophia456@gmail.com', '$2a$11$d8eUTAJlZlEAE6PkSk94j.eUqe/6uZkKwzKvzcBhjDrgFtrxZzAUO', '2025-07-22 13:46:34.455047+07', '4/r+D7exB1YjmoHLEvMfLqsWc+yn2gtMP2yqUlptfK0=', 'Qzr1l3oRURc9PhKdbIezKpbKtT9iAnMHQAaNRLvUcV4=', '2025-06-21 16:05:56.159602+07') ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('261b46f0-8adc-4dd3-a99a-d726aac8ba11', 'ME', 'davidlee ', '2025-07-11', '987654321000', 'davidlee@gmail.com', '$2a$11$x5jbjZvwC9ixDZP2ns7oHe51wDS0YpFP.jCCz8NjwHcnphc1orcXG', '2025-07-22 13:46:34.455047+07', '4/r+D7exB1YjmoHLEvMfLqsWc+yn2gtMP2yqUlptfK0=', 'Qzr1l3oRURc9PhKdbIezKpbKtT9iAnMHQAaNRLvUcV4=', '2025-06-21 16:05:56.159602+07') ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('6c042726-a58f-4b78-8173-651286643569', 'ME', 'Hello2', '2025-06-30', '', 'hello2@example.com', '$2a$11$0J9Hik6KLRZrhfLi6Kpg2ORPVZ1Et8EZJsS0TJL5pEuPBiN8o5sD2', '2025-07-24 10:21:44.852388+07', 'a/XwHl1jobebnvwAlcZWtXNHRhH0ftGwdhFWr+PqJOE=', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('f8c42e49-b604-42a3-b659-47ec3421e738', 'ME', 'amandahall ', '2025-07-25', '6234464112', 'amandahall@gmail.com', '$2a$11$IdH830jVt.iu64K5rfIWt.nPmipUhsiBPRwTeCmaL5UMaEzTQ8uPm', '2025-07-24 10:59:58.866574+07', '8CaD1rQPRGn6FBmhFNEGuVJykgvpkaD3XXZTZT4jKis=', 'Qzr1l3oRURc9PhKdbIezKpbKtT9iAnMHQAaNRLvUcV4=', '2025-06-21 16:05:56.159602+07') ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('86df714c-8a35-445e-84e7-b673e655ff6e', 'MA', 'dsg', '2025-07-09', NULL, '1@example.com', '$2a$11$RBiv8HsktD38/JyZPcYJcudS3ouPeqfA3V6QDojXqK.6fguGUr7uK', '2025-07-24 15:02:31.919947+07', '+UNDb9Y4vhEHQaAqMBePoKT6UrgRU7wRS+A4JMKUC+o=', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('7ea921cc-a88e-45f5-ace3-e10164c89efb', 'ME', 'carter_xyz', '2025-07-15', '4234652353', 'carter_xyz@gmail.com', '$2a$11$5spyiLh7VxzeEVkzz0.mD.ZTQUroDCVoY8zLEyq4ixoJ1afz/aaXS', '2025-07-22 14:04:28.29499+07', 'uRhKMoFWJejBbFFU64wwmUILZ7wtfa4ZRmcaG1+83WI=', 'Qzr1l3oRURc9PhKdbIezKpbKtT9iAnMHQAaNRLvUcV4=', '2025-06-21 16:05:56.159602+07') ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('44836074-d231-4756-ac8f-e5a5f0102cf7', 'ME', 'dylan.official', '2025-07-15', '123342598754', 'dylan.official@gmail.com', '$2a$11$Y4F3/s1CWbgZztdN20puV.A3cOuLnMUUjsXmo2Cz5scuai9TVC3B.', '2025-07-22 14:04:28.29499+07', 'uRhKMoFWJejBbFFU64wwmUILZ7wtfa4ZRmcaG1+83WI=', 'Qzr1l3oRURc9PhKdbIezKpbKtT9iAnMHQAaNRLvUcV4=', '2025-06-21 16:05:56.159602+07') ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('836d33fd-e369-4bb0-8545-9a93524d1db0', 'ME', 'abigail_morgan', '2025-07-15', '1232143234', 'abigail_morgan@gmail.com', '$2a$11$gn5SqvDp6GUJ5E4vNqEJBu9P6CjrnSEL3P/bBwQsqSpc0RehUA9he', '2025-07-22 15:04:40.390215+07', 'bkc1AAK8KVZcV+pyaN6xYyZNe7lwqLaURpR1JH0nmWI=', 'Qzr1l3oRURc9PhKdbIezKpbKtT9iAnMHQAaNRLvUcV4=', '2025-06-21 16:05:56.159602+07') ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('5481541a-60c6-4699-ac0d-12a968525faa', 'CO', 'Charlie Consultant', '1978-07-01', '5551112222', 'charlie.c@example.com', '$2a$11$2hhOJQkI05tjZLL0HGigruSsBt.G.n15zxNKUHDtTmhsQn1YKw50S', '2025-07-24 15:01:58.874013+07', 'Mo7yvS0XzHYBSlhMBlfk6q+UWrldwsyu6y9vaSVi8LE=', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('97efa7db-b26a-44c9-8591-57044877656b', 'ME', 'leo.alpha', '2025-07-15', '45365634445', 'leo.alpha@gmail.com', '$2a$11$W5VFERjQhbq69U26TuyiEuV7mXMuZpDGCjdtOJgLvs9PMEPdWlLue', '2025-07-22 14:04:28.29499+07', 'uRhKMoFWJejBbFFU64wwmUILZ7wtfa4ZRmcaG1+83WI=', 'Qzr1l3oRURc9PhKdbIezKpbKtT9iAnMHQAaNRLvUcV4=', '2025-06-21 16:05:56.159602+07') ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('d7b45f18-bd7c-4c62-94bf-d9901a3da986', 'ME', 'madison+work', '2025-07-15', '1245243546', 'madison+work@gmail.com', '$2a$11$XP9wlgKVxgaxUGAxzuWMo.o1Hs1aKSWGZMO3P7.jSvs5d7mR7ijS.', '2025-07-22 14:04:28.29499+07', 'uRhKMoFWJejBbFFU64wwmUILZ7wtfa4ZRmcaG1+83WI=', 'Qzr1l3oRURc9PhKdbIezKpbKtT9iAnMHQAaNRLvUcV4=', '2025-06-21 16:05:56.159602+07') ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('4a66d5db-a2ee-4c02-a0af-8c4db5ad96b4', 'ME', 'mason_rogers', '2025-07-15', '1233242553', 'mason_rogers@gmail.com', '$2a$11$./sWpg3tL1Mta9VCRXCgtOSxwadaOUM1.h3zEN7S5Inc0/99sX/Jm', '2025-07-22 14:04:28.29499+07', 'uRhKMoFWJejBbFFU64wwmUILZ7wtfa4ZRmcaG1+83WI=', 'Qzr1l3oRURc9PhKdbIezKpbKtT9iAnMHQAaNRLvUcV4=', '2025-06-21 16:05:56.159602+07') ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('9c848a92-3794-4a14-9191-bfa3d504d7af', 'ME', 'nora-jane', '2025-07-15', '25123531234', 'nora-jane@gmail.com', '$2a$11$KbbA89pFKeSUpThAhlhcbeGeTyoVEnvI/68b.zTuzYctHNGKSASOq', '2025-07-22 14:04:28.29499+07', 'uRhKMoFWJejBbFFU64wwmUILZ7wtfa4ZRmcaG1+83WI=', 'Qzr1l3oRURc9PhKdbIezKpbKtT9iAnMHQAaNRLvUcV4=', '2025-06-21 16:05:56.159602+07') ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('3ee49d1a-2a2d-4fc1-bc9b-c33ab81fdf53', 'ME', 'samuel1234 ', '2025-07-15', '13242234632', 'samuel1234@gmail.com', '$2a$11$Zo6Sry7VbhyC.ceHDU.O8u06ihPLpK6KBsVtjZIFDNmuCPW6pKH3C', '2025-07-22 14:04:28.29499+07', 'uRhKMoFWJejBbFFU64wwmUILZ7wtfa4ZRmcaG1+83WI=', 'Qzr1l3oRURc9PhKdbIezKpbKtT9iAnMHQAaNRLvUcV4=', '2025-06-21 16:05:56.159602+07') ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('09a46f92-2bcb-4ede-8b9e-c91a19678c86', 'ME', 'sarahwilson ', '2025-07-05', '97824379822', 'sarahwilson@gmail.com', '$2a$11$guB83ARmx34J3jOTAfHby.XoXB3NVfPk2FgWghZSpPAflQyLIHTRS', '2025-07-22 13:46:34.455047+07', '4/r+D7exB1YjmoHLEvMfLqsWc+yn2gtMP2yqUlptfK0=', 'Qzr1l3oRURc9PhKdbIezKpbKtT9iAnMHQAaNRLvUcV4=', '2025-06-21 16:05:56.159602+07') ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('44c06998-90b5-4571-814e-488b79dff577', 'ME', 'taylor+news', '2025-07-15', '1242352565', 'taylor+news@gmail.com', '$2a$11$ei99ATHEocCACOOfGNDUpuT.0kXVcNffvWpjDatOKDd6LAIpnd5aq', '2025-07-22 14:04:28.29499+07', 'uRhKMoFWJejBbFFU64wwmUILZ7wtfa4ZRmcaG1+83WI=', 'Qzr1l3oRURc9PhKdbIezKpbKtT9iAnMHQAaNRLvUcV4=', '2025-06-21 16:05:56.159602+07') ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('34a117c4-d333-4ffe-81b2-91d1566b1901', 'ME', 'gabriel.2024', '2025-07-15', '1322543623', 'gabriel.2024@gmail.com', '$2a$11$G32jpe4hIamGcaDUDgNTcOJQ7hfeJRfPJ6gQm/vu.Lo0qz1wVIx3i', '2025-07-22 14:04:28.29499+07', 'uRhKMoFWJejBbFFU64wwmUILZ7wtfa4ZRmcaG1+83WI=', 'Qzr1l3oRURc9PhKdbIezKpbKtT9iAnMHQAaNRLvUcV4=', '2025-06-21 16:05:56.159602+07') ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('3771235c-14d1-40c5-90a1-cd479425ffe4', 'ME', 'victoria_123', '2025-07-15', '12325365253', 'victoria_123@gmail.com', '$2a$11$6KdzGYgKmUlAJ9g.YBUDPOqC1I/OLPzFc5F300ikvCv0eFVUs8ZUq', '2025-07-22 14:04:28.29499+07', 'uRhKMoFWJejBbFFU64wwmUILZ7wtfa4ZRmcaG1+83WI=', 'Qzr1l3oRURc9PhKdbIezKpbKtT9iAnMHQAaNRLvUcV4=', '2025-06-21 16:05:56.159602+07') ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('afdc5af2-0821-45c6-8244-cca9c84ca21e', 'ME', 'harper_cook', '2025-07-15', '24323465234', 'harper_cook@gmail.com', '$2a$11$LggPjQ4SjYcSEthTW/5nVOvhjhKWyId4.5AteTDx5r/lFCyUIfXLC', '2025-07-22 14:04:28.29499+07', 'uRhKMoFWJejBbFFU64wwmUILZ7wtfa4ZRmcaG1+83WI=', 'Qzr1l3oRURc9PhKdbIezKpbKtT9iAnMHQAaNRLvUcV4=', '2025-06-21 16:05:56.159602+07') ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('214ed068-9d2b-4929-ba49-966e88f82fba', 'ME', 'isabella99', '2025-07-15', '322134566332', 'isabella99@gmail.com', '$2a$11$05VvurTba5Yx0bnSKmNLjOjhbt1hRN18SUBCBCdXLTilEgFJXsHjO', '2025-07-22 14:04:28.29499+07', 'uRhKMoFWJejBbFFU64wwmUILZ7wtfa4ZRmcaG1+83WI=', 'Qzr1l3oRURc9PhKdbIezKpbKtT9iAnMHQAaNRLvUcV4=', '2025-06-21 16:05:56.159602+07') ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('6e883367-259b-47df-9fac-c96c945414f0', 'AD', 'TEST for', '2025-07-09', '123562346523', 'user2024@example.com', '$2a$11$yey7PstOKE5ZygN2CKoWH.WU/8jzavmCu2UzS8B3jBbqGiUBN3CZC', '2025-07-24 10:02:38.363681+07', 'Rb8ThStiUGm1Byr2IzNPel+Af0A79dT2rt5jm/8CP10=', 'Qzr1l3oRURc9PhKdbIezKpbKtT9iAnMHQAaNRLvUcV4=', '2025-06-21 16:05:56.159602+07') ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('ee26b72a-0caa-4837-ab92-98cc3551c029', 'ME', 'James ', '2025-07-04', '12345678910', 'james.carter@example.com', '$2a$11$i5siKqDxC5LuTY5qpuApSuK280evO0xyGgRmsVoi6xCluHCbcse3C', '2025-07-24 10:01:45.950104+07', 'eZC2iMVXim4kBFBttpt3UMx3g8fTzJGBews0VPYTSNU=', 'Qzr1l3oRURc9PhKdbIezKpbKtT9iAnMHQAaNRLvUcV4=', '2025-06-21 16:05:56.159602+07') ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('4b84c142-8667-4bb4-aa05-ec0bb0a854fd', 'ME', 'create', '2025-07-01', '1234561234', 'artist@creative.studio', '$2a$11$qc.LEjNenvlDCE2AV/ufxOLOrY0.EjJnl/VPPyzj0uQG4SpkydBAi', '2025-07-24 10:24:04.079836+07', 'XSk0CYOExtyjF5T2K2ulFTZKvXx/p5r2KUNn3m7JHnc=', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('323df359-1445-4888-9a32-5e29f5b082a3', 'ME', '443kbgjr', '2025-07-18', '5732442373535', 'abc@gmail.com', '$2a$11$A0Ccivi68w81QE.dJvlNiuBqj/QcRPMHptnZR6800iOGvalrw/hfS', NULL, NULL, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('7a59aab6-aa00-4255-b012-a8cd52178f82', 'ME', 'admin2', '2025-07-18', NULL, 'admin2@example.com', '$2a$11$sqipyY8GxsAyBr4ekKCTG.6aGT6.Qo6EaqUE1SF9LjkzBbGycc7Ka', '2025-07-25 15:43:08.741771+07', 'QFdwmP/cBu/G0ULpNdiP8SZqWPKuD3MLQBgPHAUO1RE=', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('5c794738-5fd7-478e-ad74-cbab7c35e4f7', 'ME', '34kky', '2025-07-18', '46573856735', 'abcdefg@gmail.com', '$2a$11$ye5gQ3Lv9yrtxa6o59JE8.FZb5zMnccDK9ZctpM1H2JuMNQdrrCcK', '2025-07-25 15:41:40.745599+07', '5r3LTU4UANeb/Zd5GW0kqDQOmBgDUfQ66boX+66D1NM=', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('571ae483-e032-4095-b4eb-3e8a2e1014a5', 'ME', 'admin3@example.com', '2025-07-18', '53354745744', 'admin3@example.com', '$2a$11$5EPN7k8oN0M6FBB6ONztm.gBRk.UXMEPJupSiodRQLBa4TEGeNSdm', '2025-07-25 15:44:04.604459+07', 'AviAH4WgfT2Uca9IQm1Gt52ekfq7enl0Sr0n0dMB9rE=', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('47ce04c3-4ed2-4740-87e8-d9299f974d97', 'AD', 'NHÂN', '2025-07-18', '123654346523', 'von2441@gmail.com', '$2a$11$Dvm.DRJncaIdwaSyB/k6IOXRd7axC6LZ7UVwi4VtYMTEnuC1X.4za', '2025-07-25 15:46:08.047551+07', 'YvSs7/LfU4zI/Ix+TNvEGpj7ZIdKwzOEt/8EkITzShk=', 'Qzr1l3oRURc9PhKdbIezKpbKtT9iAnMHQAaNRLvUcV4=', '2025-06-21 16:05:56.159602+07') ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('d6ea2ff3-2276-449a-bbfe-65a566d000a0', 'AD', 'phucle123', '2025-07-18', '123958575757554', 'phucle123@gmail.com', '$2a$11$7NKQJLFmLRWiHPc/H2vy.OPCkEEH4tLixfrL5sKaE.mj6vEZLf6W6', '2025-07-25 15:49:33.68867+07', '7td305WWy3bOopsK8ETKVmaZ83U4ddiWOCSsHsZXk7Y=', 'Qzr1l3oRURc9PhKdbIezKpbKtT9iAnMHQAaNRLvUcV4=', '2025-06-21 16:05:56.159602+07') ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('62d6b0a3-567e-4592-8772-a2ea3b5809e6', 'ME', 'jane2321', '2025-07-24', '12352153251234', 'khoitestmember9@gmail.com', '$2a$11$xIwRnV4.UKilY.SAF6zv2umir76H2hiKNNjlrMu4Gg8OYPQUgF1We', '2025-07-25 15:50:26.742077+07', 'GunpZGc5IcoNHNf5NzOo95+KmN9H8xpobVaZ8ISBPYg=', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('70ee2c65-7a58-4067-865e-e8cc8786b5a6', 'ME', 'khádasd', '2025-07-19', '123456789123', 'khoitestmember10@gmail.com', '$2a$11$49p66/xtLdEy2Pber.ANwOf4qrv84bVKigpTdcpQhFxj2J5vyh3f6', '2025-07-25 15:51:38.11674+07', 'CBJPJOQDtZf5TXDUFuBa6xk9sSY6WtsMDbxPqnhBb1U=', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('f8aa35ca-60d7-42b8-a857-d9d1d63ef949', 'AD', 'noidea1233', '2025-07-18', '123654346529', 'khoitestmember11@gmail.com', '$2a$11$CSs3kDg0YTxhbTQv/0HewOBYoK6X6lHc3cLpIvhKiCXAAfiT9XIqO', '2025-07-25 15:52:59.891868+07', 'bU3GPn0X/xh5XVLSexpMPaqwND5azG4zQF2X0uc2qd4=', 'Qzr1l3oRURc9PhKdbIezKpbKtT9iAnMHQAaNRLvUcV4=', '2025-06-21 16:05:56.159602+07') ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('6e924b1b-08a1-47e2-b170-a07f849f9cee', 'ME', 'admin7', '2025-07-18', '12367865498', 'admin7@gmail.com', '$2a$11$8JdBFPNtwZ0n3cUTyrEOO.PB6cGSSJRyyluDc9KnJT06rU1mfFOe.', '2025-07-25 15:53:17.61762+07', 'N6cEs4pwCPFc315dxrdjO7QZf1ElgPqbdam+GapFL+E=', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('5fc8e0b9-7b2c-47f5-897a-05ecd1e209da', 'AD', 'háds', '2025-07-18', '12365213123', 'khoitestmember12@gmail.com', '$2a$11$5iZL0X.DW.uqEhZGjv87SON0BGP7CDIHi6Kb0ZfYcLq.LH5DDGvwy', '2025-07-25 15:53:52.420674+07', '5t/8yaLROs/cqGHcaB7Ql05qU8bp0bkuPIhyBPNLIcI=', 'Qzr1l3oRURc9PhKdbIezKpbKtT9iAnMHQAaNRLvUcV4=', '2025-06-21 16:05:56.159602+07') ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('c6e1b498-7d6d-4da8-9f6a-407ff21e98e4', 'AD', 'Admin', '1990-01-03', '1234567890', 'admin@example.com', '$2a$11$6a3Rb03SXjxbCdEcJWOvSuSs2L5ZoCByP62V9m99UnJD5eL9fpK9G', '2025-07-30 22:30:37.497042+07', 'aMCKeQCdeHgh/wTQDxYxI89mwz4Rt5HkDT2Vlz++17E=', 'Qzr1l3oRURc9PhKdbIezKpbKtT9iAnMHQAaNRLvUcV4=', '2025-06-21 16:05:56.159602+07') ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('c605e8b3-a30d-412c-9400-4c71e62ba8aa', 'AD', 'bihoang', '2025-07-18', '12365321322', 'khoitestmember13@gmail.com', '$2a$11$98zpZXf6gmnaKNRLs8jN/e.ZjYI6WUdHxvtQ4/KrUUZaW2Ap35Wbq', '2025-07-25 15:54:28.913197+07', 'LDvx8d9yJaxFD6PQyh7GcnTwznLka5CJtClddgxLbwo=', 'Qzr1l3oRURc9PhKdbIezKpbKtT9iAnMHQAaNRLvUcV4=', '2025-06-21 16:05:56.159602+07') ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('819195c4-d243-4dd4-b4e2-38479eb0706f', 'ME', 'phuclefix', '2025-07-18', '123678174883', 'phuclefix@gmail.com', '$2a$11$a3QcvCMdie/WJqissW9AmO0LUi41Mv.SVnxpHnDoJ7wquj95mwWha', '2025-07-25 15:59:17.419754+07', 'O4JjjYHgzMRPQJBAjU6dDeE305N25cPh90QIAkvebbQ=', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('92e0e045-c5c1-46a4-b059-83d57dbd22c5', 'ME', 'admin4@example.com', '2025-07-18', '123562346524', 'admin4@example.com', '$2a$11$d6rCy4uIJy7GIu0e0PB0Z.JMMkNsOeRo0xxtRNFPCkOVli.Yswq/i', '2025-07-25 16:59:58.905111+07', 'Qa2O3IDezPNu23DdWMvHFBlhwcTtgEU2iM8+sCxiOK8=', 'Qzr1l3oRURc9PhKdbIezKpbKtT9iAnMHQAaNRLvUcV4=', '2025-06-21 16:05:56.159602+07') ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('a162c9f1-a98d-43d7-a710-2683beb00919', 'ME', 'admin8@example.com', '2025-07-18', '123562346527', 'admin8@example.com', '$2a$11$hQQOXJ18UhlQZgWZ4qlm9eebYveM3gajLqt9MCt8beDmCOHQtAcKq', '2025-07-25 17:01:25.371405+07', 'LZ9fu6jxnDUldDmMSRfvVl8W0O994r/2cDRhwrCdkds=', 'Qzr1l3oRURc9PhKdbIezKpbKtT9iAnMHQAaNRLvUcV4=', '2025-06-21 16:05:56.159602+07') ON CONFLICT DO NOTHING;
INSERT INTO public."User" VALUES ('c96d8d61-93dd-4637-9f21-a9df16162890', 'ME', 'khôi', '2025-06-12', '09023193919', 'khoipham27052005@gmail.com', '$2a$11$gviwRU.YyYqNMozOTvGAu.NP.fSRnGGeQfUezHtsO15Dv5cNYKuLK', '2025-07-30 12:16:43.369248+07', '7SSSYcvWVqz3xYUczbdUd625dT/3udqwoMtP8BDffFs=', 's43OuUvnNpQecMVQVaZ5yheiZcqIJNK5Tvndc7Rt+So=', '2025-07-18 16:34:41.349211+07') ON CONFLICT DO NOTHING;


--
-- TOC entry 4971 (class 0 OID 17517)
-- Dependencies: 231
-- Data for Name: __EFMigrationsHistory; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4745 (class 2606 OID 17528)
-- Name: Appointment Appointment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Appointment"
    ADD CONSTRAINT "Appointment_pkey" PRIMARY KEY ("AppointmentId");


--
-- TOC entry 4751 (class 2606 OID 17530)
-- Name: AssessmentAnswer AssessmentAnswers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AssessmentAnswer"
    ADD CONSTRAINT "AssessmentAnswers_pkey" PRIMARY KEY ("AnswerId");


--
-- TOC entry 4754 (class 2606 OID 17532)
-- Name: AssessmentQuestion AssessmentQuestions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AssessmentQuestion"
    ADD CONSTRAINT "AssessmentQuestions_pkey" PRIMARY KEY ("QuestionId");


--
-- TOC entry 4757 (class 2606 OID 17534)
-- Name: AssessmentResult AssessmentResults_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AssessmentResult"
    ADD CONSTRAINT "AssessmentResults_pkey" PRIMARY KEY ("ResultId");


--
-- TOC entry 4749 (class 2606 OID 17536)
-- Name: Assessment Assessments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Assessment"
    ADD CONSTRAINT "Assessments_pkey" PRIMARY KEY ("AssessmentId");


--
-- TOC entry 4764 (class 2606 OID 17538)
-- Name: BlogTopic BlogTopic_BlogTopicName_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."BlogTopic"
    ADD CONSTRAINT "BlogTopic_BlogTopicName_key" UNIQUE ("BlogTopicName");


--
-- TOC entry 4766 (class 2606 OID 17540)
-- Name: BlogTopic BlogTopic_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."BlogTopic"
    ADD CONSTRAINT "BlogTopic_pkey" PRIMARY KEY ("BlogTopicId");


--
-- TOC entry 4761 (class 2606 OID 17542)
-- Name: Blog Blog_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Blog"
    ADD CONSTRAINT "Blog_pkey" PRIMARY KEY ("BlogId");


--
-- TOC entry 4771 (class 2606 OID 17544)
-- Name: CampaignRegistrations CampaignRegistrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CampaignRegistrations"
    ADD CONSTRAINT "CampaignRegistrations_pkey" PRIMARY KEY ("RegistrationId");


--
-- TOC entry 4768 (class 2606 OID 17546)
-- Name: Campaign Campaign_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Campaign"
    ADD CONSTRAINT "Campaign_pkey" PRIMARY KEY ("CampaignId");


--
-- TOC entry 4777 (class 2606 OID 17548)
-- Name: CourseEnroll CourseEnroll_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CourseEnroll"
    ADD CONSTRAINT "CourseEnroll_pkey" PRIMARY KEY ("EnrollId");


--
-- TOC entry 4781 (class 2606 OID 17550)
-- Name: CourseTopic CourseTopic_TopicName_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CourseTopic"
    ADD CONSTRAINT "CourseTopic_TopicName_key" UNIQUE ("TopicName");


--
-- TOC entry 4783 (class 2606 OID 17552)
-- Name: CourseTopic CourseTopic_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CourseTopic"
    ADD CONSTRAINT "CourseTopic_pkey" PRIMARY KEY ("TopicId");


--
-- TOC entry 4773 (class 2606 OID 17554)
-- Name: Course Course_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Course"
    ADD CONSTRAINT "Course_pkey" PRIMARY KEY ("CourseId");


--
-- TOC entry 4794 (class 2606 OID 17556)
-- Name: __EFMigrationsHistory PK___EFMigrationsHistory; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."__EFMigrationsHistory"
    ADD CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId");


--
-- TOC entry 4785 (class 2606 OID 17558)
-- Name: Role Role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Role"
    ADD CONSTRAINT "Role_pkey" PRIMARY KEY ("RoleId");


--
-- TOC entry 4787 (class 2606 OID 17560)
-- Name: User User_Email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_Email_key" UNIQUE ("Email");


--
-- TOC entry 4789 (class 2606 OID 17562)
-- Name: User User_Username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_Username_key" UNIQUE ("Username");


--
-- TOC entry 4791 (class 2606 OID 17564)
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY ("UserId");


--
-- TOC entry 4746 (class 1259 OID 17565)
-- Name: idx_appointment_consultantid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_appointment_consultantid ON public."Appointment" USING btree ("ConsultantId");


--
-- TOC entry 4747 (class 1259 OID 17566)
-- Name: idx_appointment_memberid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_appointment_memberid ON public."Appointment" USING btree ("MemberId");


--
-- TOC entry 4752 (class 1259 OID 17567)
-- Name: idx_assessment_answers_questionid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_assessment_answers_questionid ON public."AssessmentAnswer" USING btree ("QuestionId");


--
-- TOC entry 4755 (class 1259 OID 17568)
-- Name: idx_assessment_questions_assessmentid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_assessment_questions_assessmentid ON public."AssessmentQuestion" USING btree ("AssessmentId");


--
-- TOC entry 4758 (class 1259 OID 17569)
-- Name: idx_assessment_results_assessmentid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_assessment_results_assessmentid ON public."AssessmentResult" USING btree ("AssessmentId");


--
-- TOC entry 4759 (class 1259 OID 17570)
-- Name: idx_assessment_results_memberid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_assessment_results_memberid ON public."AssessmentResult" USING btree ("MemberId");


--
-- TOC entry 4762 (class 1259 OID 17571)
-- Name: idx_blog_staffid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_blog_staffid ON public."Blog" USING btree ("StaffId");


--
-- TOC entry 4769 (class 1259 OID 17572)
-- Name: idx_campaign_staffid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_campaign_staffid ON public."Campaign" USING btree ("StaffId");


--
-- TOC entry 4774 (class 1259 OID 17573)
-- Name: idx_course_staffid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_course_staffid ON public."Course" USING btree ("StaffId");


--
-- TOC entry 4775 (class 1259 OID 17574)
-- Name: idx_course_topicid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_course_topicid ON public."Course" USING btree ("TopicId");


--
-- TOC entry 4778 (class 1259 OID 17575)
-- Name: idx_courseenroll_courseid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_courseenroll_courseid ON public."CourseEnroll" USING btree ("CourseId");


--
-- TOC entry 4779 (class 1259 OID 17576)
-- Name: idx_courseenroll_memberid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_courseenroll_memberid ON public."CourseEnroll" USING btree ("MemberId");


--
-- TOC entry 4792 (class 1259 OID 17577)
-- Name: idx_user_roleid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_roleid ON public."User" USING btree ("RoleId");


--
-- TOC entry 4795 (class 2606 OID 17578)
-- Name: Appointment Appointment_ConsultantId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Appointment"
    ADD CONSTRAINT "Appointment_ConsultantId_fkey" FOREIGN KEY ("ConsultantId") REFERENCES public."User"("UserId") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4796 (class 2606 OID 17583)
-- Name: Appointment Appointment_MemberId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Appointment"
    ADD CONSTRAINT "Appointment_MemberId_fkey" FOREIGN KEY ("MemberId") REFERENCES public."User"("UserId") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4797 (class 2606 OID 17588)
-- Name: AssessmentAnswer AssessmentAnswers_QuestionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AssessmentAnswer"
    ADD CONSTRAINT "AssessmentAnswers_QuestionId_fkey" FOREIGN KEY ("QuestionId") REFERENCES public."AssessmentQuestion"("QuestionId") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4798 (class 2606 OID 17593)
-- Name: AssessmentQuestion AssessmentQuestions_AssessmentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AssessmentQuestion"
    ADD CONSTRAINT "AssessmentQuestions_AssessmentId_fkey" FOREIGN KEY ("AssessmentId") REFERENCES public."Assessment"("AssessmentId") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4799 (class 2606 OID 17598)
-- Name: AssessmentResult AssessmentResults_AssessmentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AssessmentResult"
    ADD CONSTRAINT "AssessmentResults_AssessmentId_fkey" FOREIGN KEY ("AssessmentId") REFERENCES public."Assessment"("AssessmentId") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4800 (class 2606 OID 17603)
-- Name: AssessmentResult AssessmentResults_MemberId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AssessmentResult"
    ADD CONSTRAINT "AssessmentResults_MemberId_fkey" FOREIGN KEY ("MemberId") REFERENCES public."User"("UserId") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4801 (class 2606 OID 17608)
-- Name: Blog Blog_BlogTopicId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Blog"
    ADD CONSTRAINT "Blog_BlogTopicId_fkey" FOREIGN KEY ("BlogTopicId") REFERENCES public."BlogTopic"("BlogTopicId") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4802 (class 2606 OID 17613)
-- Name: Blog Blog_StaffId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Blog"
    ADD CONSTRAINT "Blog_StaffId_fkey" FOREIGN KEY ("StaffId") REFERENCES public."User"("UserId") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4804 (class 2606 OID 17618)
-- Name: CampaignRegistrations CampaignRegistrations_CampaignId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CampaignRegistrations"
    ADD CONSTRAINT "CampaignRegistrations_CampaignId_fkey" FOREIGN KEY ("CampaignId") REFERENCES public."Campaign"("CampaignId") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4805 (class 2606 OID 17623)
-- Name: CampaignRegistrations CampaignRegistrations_MemberId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CampaignRegistrations"
    ADD CONSTRAINT "CampaignRegistrations_MemberId_fkey" FOREIGN KEY ("MemberId") REFERENCES public."User"("UserId") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4803 (class 2606 OID 17628)
-- Name: Campaign Campaign_StaffId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Campaign"
    ADD CONSTRAINT "Campaign_StaffId_fkey" FOREIGN KEY ("StaffId") REFERENCES public."User"("UserId") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4809 (class 2606 OID 17633)
-- Name: CourseEnroll CourseEnroll_CourseId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CourseEnroll"
    ADD CONSTRAINT "CourseEnroll_CourseId_fkey" FOREIGN KEY ("CourseId") REFERENCES public."Course"("CourseId") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4810 (class 2606 OID 17638)
-- Name: CourseEnroll CourseEnroll_MemberId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CourseEnroll"
    ADD CONSTRAINT "CourseEnroll_MemberId_fkey" FOREIGN KEY ("MemberId") REFERENCES public."User"("UserId") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4806 (class 2606 OID 17643)
-- Name: Course Course_ConsultantId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Course"
    ADD CONSTRAINT "Course_ConsultantId_fkey" FOREIGN KEY ("ConsultantId") REFERENCES public."User"("UserId") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4807 (class 2606 OID 17648)
-- Name: Course Course_StaffId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Course"
    ADD CONSTRAINT "Course_StaffId_fkey" FOREIGN KEY ("StaffId") REFERENCES public."User"("UserId") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4808 (class 2606 OID 17653)
-- Name: Course Course_TopicId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Course"
    ADD CONSTRAINT "Course_TopicId_fkey" FOREIGN KEY ("TopicId") REFERENCES public."CourseTopic"("TopicId");


--
-- TOC entry 4811 (class 2606 OID 17658)
-- Name: User User_RoleId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_RoleId_fkey" FOREIGN KEY ("RoleId") REFERENCES public."Role"("RoleId");


-- Completed on 2025-07-30 22:57:35

--
-- PostgreSQL database dump complete
--

