Miguel Lock
SFE-128-A
Log Parsing 2


- Examine the `analysis2` directory, `routerlogtest2.txt` file with data from a set of network routers.
- **Scenario**: A hacker has gotten into several of your routers between 09 Jun and 11 June, resulting in shutdown of certain routers. Luckily you have remotely backed-up logging, and are given a text file with the affected dates. The hacker’s signature set of lines in order looks like this:
  - `%SEC_LOGIN-5-LOGIN_SUCCESS: Login Success`
  - `%SYS-5-CONFIG_I: Configured from console by authuser1 on vty1`
  - `%SYS-5-PRIV_AUTH_PASS: Privilege level set`
  - `%OS-SYSLOG-4-LOG_WARNING: PAM detected CPU hog for cpu_hogger on 0_RP0_CPU0`
  - `%OS-SYSLOG-4-LOG_WARNING: PAM detected /misc/config is full on 0_1_CPU0`
  - Unfortunately, the hacker got smarter, and put time delays between the penetration attempts.

3. Using perl, develop a "cpu_hogger" script that will take a log file as its input and identify any router affected by this `cpu_hogger` hack pattern. The output of the `cpu_hogger` should indicate router id, the 'initial impact' date/time (in GMT) and 'intrusion detected' date/time (GMT).  
   *(Output: One device + two date/time fields per row)*

4. Test your work on the original `routerlogtest1.txt` [log data from 07 Jun and 09 June.]

5. Your report should tell your professor the names of the routers and the time the attack began (most recent login success prior to authuser1 configuration) and ended (/misc/config full after CPU hog detected) for each device.

6. You will also include the script and very short (1 paragraph) description of process that lead to your finds.