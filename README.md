# Members Forms

This collection of XSLT utilities will help you integrate the Members extension into your Symphony website. It can save many hours (probably days) of work.

You should know how a members system basically works. If you have no idea, please take a look at the [Members README](https://github.com/symphonycms/members) and the [Members Wiki](https://github.com/symphonycms/members/wiki), especially the [Big Picture](https://github.com/symphonycms/members/wiki/The-Big-Picture).

**What can Members Forms do for you?**

- Auto-render your HTML form elements in a consistent way.
- Auto-render "invalid" class attributes for form elements.
- Auto-render validation summaries for events, featuring:
	- configurable event message validation summaries (e.g. "Your registration has been saved successfully.");
	- configurable field level error messages (e.g. "You are late. This username is already taken.");
- Auto-render validation summaries for filter options, containing configurable messages (e.g. "An email has been sent to you. Read it!")
- Auto-insert post-values into form inputs.

Members Forms deals with the following challenges:

- Many different event (error) messages make rendering form elements and messages on the frontend complicated. (Some generic error messages will even be output in `<error/>` nodes instead of field name nodes).
- Members provides a "pseudo event" called `member-login-info`.
- Special fields like `password`/`password-confirm`/`recovery-code` or the `identity` field need special solutions regarding field names and event XML messages alike.

Included are seven `members.form-...` utilities which simply call named templates. The interesting stuff is the following files:

- the configuration file; in the `examples` folder you find:

	- `members.config.de.xsl` (example German configuration file)
	- `members.config.en.xsl` (example English configuration file)

- `members.forms.xsl` (form templates, validation logic etc.)


## Download

Members Forms can be downloaded from Github: <http://github.com/michael-e/member-forms>


## Quick Start

1. Rename the download folder to `members-forms` and throw it into the `workspace/utilities` folder of your website.
2. Copy at least one language file and all the `members.form-...` files in the `examples` folder to the root of your `utilities` folder. This will prevent them from being overwritten if you update the `members-forms` folder. (If you move them anywhere else, you will have to change the include paths in these files.)
3. Now rename your config file to `members.config.xsl`. (If you choose a different name, you must change line 12 of `members.forms.xsl` to include the right file.)
4. If you have not done it already, set up the Members extension and a Members section.
5. Go through the configuration file and change all the field handles to reflect the field names (labels) in your Members section.

Now you can build your first Members Forms page (a simple login page):

	<?xml version="1.0" encoding="UTF-8"?>
	<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="../utilities/members.form-login.xsl"/>

	<xsl:variable name="member-is-logged-in" select="boolean(//events/member-login-info/@logged-in = 'yes')"/>

	<xsl:template match="/">
		<h1>Login</h1>
		<xsl:choose>
			<xsl:when test="$member-is-logged-in">
				<p>You are logged in. (<a href="?member-action=logout&amp;redirect={$current-url}">Logout</a>)</p>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="members-form-login"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	</xsl:stylesheet>

(Try it with missing or invalid values as well.)

## Configuration

If you look at the example files (the English configuration file and the German version), you will see that you are free to customize only a little (EN) or really a lot (DE).

**Please read those configuration files in order to understand what Members Forms is supposed to do.**

All Symphony events will render event messages in XML using Symphony's system language. This is why you will need a configuration file which fits to your system language. (You may, however, include field level messages in several languages into a single configuration file, so nothing will happen when the system language will be switched. Please take a look at the provided German configuration file `members.config.de.xsl` to see how this works).

Basically you will configure:

- a datasource name (required to build an edit form for member data);
- fields;
- events and filter options.

### Field Validation

In order to add an "invalid" class attribute to your form fields, the field configuration needs to know which errors to "listen" to. Your username field, for example, will have to include the following:

	<username type="missing" message="USERNAME is a required field."/>
	<username type="invalid" message="USERNAME contains invalid characters."/>
	<username type="invalid" message="USERNAME is already taken."/>
	<username type="invalid" message="Member not found."/>
	<error type="invalid" message="No Identity field found."/>

If any of the configured error messages occur, the field will be marked as invalid.

Because of the variety of different errors I decided to never check for `missing` or `invalid` type attribute values. Instead Members Forms always compares the `message` attribute value!

Localization/customization of error messages in validation summaries can be done by simply adding the desired string - it may even contain HTML:

	<username type="missing" message="USERNAME is a required field.">You should tell us your username. (<a href="http://en.wikipedia.org/wiki/Username">What is a username?</a>)</username>

Node names and error messages must reflect your field's label! So if the username field in your Members section is called "Name of the User", the field configuration must look like this:

	<field type="username" handle="name-of-the-user">
		<label>Your Username</label>
		<errors>
			<name-of-the-user type="missing" message="Name of the User is a required field."/>
			<name-of-the-user type="invalid" message="Name of the User contains invalid characters."/>
			<name-of-the-user type="invalid" message="Name of the User is already taken."/>
			<name-of-the-user type="invalid" message="Member not found."/>
			<error type="invalid" message="No Identity field found.">Name of the User is a required field.</error>
		</errors>
	</field>

### Event Validation

The configuration should be rather self-explanatory. You may configure custom event messages which will override Symphony's event messages. If an element is missing in the configuration, the Symphony message will be used. You may completely suppress an event message by adding an empty node to the configuration:

	<error/>

### Filter Option Validation

Filter options follow the same basic logic as events.

In addition it is possible to configure more than one filter for an event. Every __configured__ filter will get a validation summary __if it provides a message attribute__ (natively or here in the configuration file). So omitting validation for a filter option completely can be done by simply not adding the said filter to the configuration.


## Usage

When configuration is done, import the template files in your pages and call the form templates from within your page template. Here are the code snippets (assumed that you have moved the example files to the root of your `uitlities` folder):

	<xsl:import href="../utilities/members.form-register.xsl"/>
	<xsl:call-template name="members-form-register"/>

	<xsl:import href="../utilities/members.form-edit-account.xsl"/>
	<xsl:call-template name="members-form-edit-account"/>

	<xsl:import href="../utilities/members.form-activate-account.xsl"/>
	<xsl:call-template name="members-form-activate-account"/>

	<xsl:import href="../utilities/members.form-regenerate-activation-code.xsl"/>
	<xsl:call-template name="members-form-regenerate-activation-code"/>

	<xsl:import href="../utilities/members.form-login.xsl"/>
	<xsl:call-template name="members-form-login"/>

	<xsl:import href="../utilities/members.form-generate-recovery-code.xsl"/>
	<xsl:call-template name="members-form-generate-recovery-code"/>

	<xsl:import href="../utilities/members.form-reset-password.xsl"/>
	<xsl:call-template name="members-form-reset-password"/>


### Setting an ID for Input Type "submit"

Submit inputs will not have an ID by default. However, you can set an ID in your template, e.g.:

	<xsl:call-template name="members:input-submit">
		<xsl:with-param name="event" select="$event"/>
		<xsl:with-param name="id" select="'master-monster-submit-button'"/>
		<xsl:with-param name="name" select="'member-action[login]'"/>
	</xsl:call-template>

The above will result in the following output:

	<div class="input submit">
	  <input type="submit" name="member-action[login]" value="Login" id="master-monster-submit-button" />
	</div>


## Namespace

`members.forms.xsl` uses the namespace `members` for form elements and validation templates. So if you want to use these directly in your own pages or utilities, you will have to include the namespace:

	<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:members="http://michael-eichelsdoerfer.de/xslt/members"
		extension-element-prefixes="members">


## Additional Information

These XSLT utilities are based on a precise analysis of the Members extension's fields and events. Especially event XML errors and post values needed to be understood. The essence is the following:

### Errors per Event

Activate Account

	<username type="invalid" message="Member not found." label="USERNAME" />
	<email type="invalid" message="Member not found." label="EMAIL" />
	<activation type="missing" message="ACTIVATION is a required field." label="ACTIVATION" />
	<activation type="invalid" message="Activation error. Code was invalid or has expired." label="ACTIVATION" />
	<activation type="invalid" message="Member is not activated." label="ACTIVATION" />
	<error type="invalid" message="No Activation field found." />
	<error type="invalid" message="No Identity field found." />

Regenerate Activation Code

	<username type="invalid" message="Member not found." label="USERNAME" />
	<email type="invalid" message="Member not found." label="EMAIL" />
	<activation type="invalid" message="Member is already activated." label="ACTIVATION" />
	<error type="invalid" message="No Activation field found." />
	<error type="invalid" message="No Identity field found." />


Generate Recovery Code

	<username type="missing" message="USERNAME is a required field." label="USERNAME" />
	<username type="invalid" message="Member not found." label="USERNAME" />
	<email type="missing" message="EMAIL is a required field." label="EMAIL" />
	<email type="invalid" message="Member not found." label="EMAIL" />
	<error type="invalid" message="No Identity field found." />
	<error type="invalid" message="You cannot generate a recovery code while being logged in."/>

Reset Password

	<username type="invalid" message="Member not found." label="USERNAME" />
	<email type="invalid" message="Member not found." label="EMAIL" />
	<password type="missing" message="PASSWORD is a required field." label="PASSWORD" />
	<password type="invalid" message="PASSWORD is too short. It must be at least CONFIGURED characters." label="PASSWORD" />
	<password type="invalid" message="PASSWORD is not strong enough." label="PASSWORD" />
	<password type="invalid" message="PASSWORD confirmation does not match." label="PASSWORD" />
	<password type="invalid" message="No recovery code found." label="PASSWORD" />
	<error type="invalid" message="No Identity field found." />
	<error type="invalid" message="No Authentication field found."/>

New/Edit

	<message>Entry encountered errors when saving.</message>
	<username label="USERNAME" type="missing" message="USERNAME is a required field." />
	<username label="USERNAME" type="invalid" message="USERNAME is already taken." />
	<username label="USERNAME" type="invalid" message="USERNAME contains invalid characters." />
	<email label="EMAIL" type="missing" message="EMAIL is a required field." />
    <email label="EMAIL" type="invalid" message="EMAIL is already taken." />
	<email label="EMAIL" type="invalid" message="EMAIL contains invalid characters." />
	<password label="PASSWORD" type="missing" message="PASSWORD is a required field." />
	<password label="PASSWORD" type="invalid" message="PASSWORD is too short. It must be at least CONFIGURED characters." />
	<password label="PASSWORD" type="invalid" message="PASSWORD is not strong enough." />

Member Login Info (pseudo event)

	<username type="missing" message="USERNAME is a required field." label="USERNAME" />
	<email type="missing" message="EMAIL is a required field." label="EMAIL" />
	<password type="missing" message="PASSWORD is a required field." label="PASSWORD" />
	<password type="invalid" message="Invalid PASSWORD." label="PASSWORD" />
	<activation type="invalid" message="Member is not activated." label="ACTIVATION" />


### Errors per Field

Password

	<password label="PASSWORD" type="missing" message="PASSWORD is a required field." />
	<password label="PASSWORD" type="invalid" message="PASSWORD is too short. It must be at least CONFIGURED characters." />
	<password label="PASSWORD" type="invalid" message="PASSWORD is not strong enough." />
	<password label="PASSWORD" type="invalid" message="PASSWORD confirmation does not match." />
	<password label="PASSWORD" type="invalid" message="Invalid PASSWORD." />
	<password label="PASSWORD" type="invalid" message="No recovery code found." />

Username

	<username label="USERNAME" type="missing" message="USERNAME is a required field." />
	<username label="USERNAME" type="invalid" message="USERNAME is already taken." />
	<username label="USERNAME" type="invalid" message="USERNAME contains invalid characters." />
	<username label="USERNAME" type="invalid" message="Member not found." />

Email

	<email label="EMAIL" type="missing" message="EMAIL is a required field." />
    <email label="EMAIL" type="invalid" message="EMAIL is already taken." />
	<email label="EMAIL" type="invalid" message="EMAIL contains invalid characters." />
	<email label="EMAIL" type="invalid" message="Member not found." />

Activation

	<activation label="ACTIVATION" type="missing" message="ACTIVATION is a required field." />
	<activation label="ACTIVATION" type="invalid" message="Activation error. Code was invalid or has expired." />
	<activation label="ACTIVATION" type="invalid" message="Member is already activated." />
	<activation label="ACTIVATION" type="invalid" message="Member is not activated." />

Generic (no dedicated form field)

	<error type="invalid" message="No Activation field found." />
	<error type="invalid" message="No Identity field found." />
	<error type="invalid" message="No Authentication field found."/>
	<error type="invalid" message="You cannot generate a recovery code while being logged in."/>


### Event XML Post Values

	<event result="success">
		<activation-code>383a59f08a2e9d057e7c13f48bb9d5d4c50664f4</activation-code>
		<recovery-code>97b899059e3a6497ab377a238fa137b0a2e4238c</recovery-code>
		<post-values>
			<username>Hello</username>
			<email>hello@example.com</email>
			<activation>7787cc711acefef8bb6c4bbd0257b583656e757d</activation>
			<password>
				<password>HelloPassword</password>
				<confirm>HelloPassword</confirm>
				<recovery-code>70b9a071758b7753552dddf4888664ca8dc2bb73</recovery-code>
			</password>
		</post-values>
	</event>
