
+BRAKEMAN REPORT+

Application path: /media/josh/databackup/projects/trailsyserver
Rails version: 5.1.3
Brakeman version: 3.7.2
Started at 2017-09-24 17:27:37 -0500
Duration: 14.083524888 seconds
Checks run: BasicAuth, BasicAuthTimingAttack, ContentTag, CreateWith, CrossSiteScripting, DefaultRoutes, Deserialize, DetailedExceptions, DigestDoS, DynamicFinders, EscapeFunction, Evaluation, Execute, FileAccess, FileDisclosure, FilterSkipping, ForgerySetting, HeaderDoS, I18nXSS, JRubyXML, JSONEncoding, JSONParsing, LinkTo, LinkToHref, MailTo, MassAssignment, MimeTypeDoS, ModelAttrAccessible, ModelAttributes, ModelSerialize, NestedAttributes, NestedAttributesBypass, NumberToCurrency, QuoteTableName, Redirect, RegexDoS, Render, RenderDoS, RenderInline, ResponseSplitting, RouteDoS, SQL, SQLCVEs, SSLVerify, SafeBufferManipulation, SanitizeMethods, SelectTag, SelectVulnerability, Send, SendFile, SessionManipulation, SessionSettings, SimpleFormat, SingleQuotes, SkipBeforeFilter, StripTags, SymbolDoSCVE, TranslateBug, UnsafeReflection, ValidationRegex, WithoutProtection, XMLDoS, YAMLParsing


+SUMMARY+

+-------------------+-------+
| Scanned/Reported  | Total |
+-------------------+-------+
| Controllers       | 20    |
| Models            | 17    |
| Templates         | 106   |
| Errors            | 1     |
| Security Warnings | 1 (0) |
+-------------------+-------+

+--------------+-------+
| Warning Type | Total |
+--------------+-------+
| Redirect     | 1     |
+--------------+-------+


+Errors+

+--------------------------------------------------------------------------------------------------------------------+---------------------------------------------------------------------------------------------+
| Error                                                                                                              | Location                                                                                    |
+--------------------------------------------------------------------------------------------------------------------+---------------------------------------------------------------------------------------------+
| /media/josh/databackup/projects/trailsyserver/app/views/alerts/new.html.erb:5 :: parse error on value ":" (tCOLON) | Could not parse /media/josh/databackup/projects/trailsyserver/app/views/alerts/new.html.erb |
+--------------------------------------------------------------------------------------------------------------------+---------------------------------------------------------------------------------------------+

+SECURITY WARNINGS+

+------------+-------------------+--------+--------------+------------------------------------------------------------------------------------------------------------------------------------+
| Confidence | Class             | Method | Warning Type | Message                                                                                                                            |
+------------+-------------------+--------+--------------+------------------------------------------------------------------------------------------------------------------------------------+
| Weak       | UpdatesController | update | Redirect     | Possible unprotected redirect near line 51: redirect_to(Update.find(+params[:id]+), :notice => "Update was successfully updated.") |
+------------+-------------------+--------+--------------+------------------------------------------------------------------------------------------------------------------------------------+
