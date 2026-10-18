defmodule MqaPortfolioWeb.ExperienceLive do
  use MqaPortfolioWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :page_title, "Experience")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_path="/experience">
      <section class="py-20 bg-base-100">
        <div class="max-w-5xl mx-auto px-4">
          <div class="text-center mb-16">
            <h1 class="text-5xl font-bold">Experience</h1>
            <p class="text-base-content/60 mt-3 text-lg">
              20 years of building and operating production systems
            </p>
          </div>

          <ul class="timeline timeline-vertical timeline-snap-icon">
            <%!-- VinCSS --%>
            <li>
              <div class="timeline-middle">
                <.icon name="hero-check-circle-solid" class="size-6 text-primary" />
              </div>
              <div class="timeline-start md:text-end mb-10">
                <time class="font-mono text-sm text-primary font-bold">2022 - Present</time>
                <span class="badge badge-primary badge-sm ml-2">Current</span>
                <div class="text-xl font-bold mt-2">VinCSS</div>
                <div class="text-base-content/70 font-semibold text-lg">Senior DevOps Engineer</div>
                <div class="mt-3 text-base-content/60 text-sm space-y-1">
                  <p>
                    Platform and infrastructure lead for the company's passwordless (FIDO2) and zero-trust access products, from Kubernetes operations to customer deployments and compliance.
                  </p>
                  <ul class="list-disc list-outside pl-5 space-y-1 text-left">
                    <li>
                      Architected the FIDO2 authentication platform on Kubernetes (24+ microservices: auth APIs, identity management, OAuth2/OIDC/SAML), with GitOps through GitLab CI/CD and ArgoCD, Istio blue/green releases and disaster recovery with an RTO under 15 minutes.
                    </li>
                    <li>
                      Zero-trust access that replaces a traditional VPN for operations teams: Teleport (with WebAuthn SSO), a central OIDC identity provider (Keycloak), HA Postgres (Patroni, pgBackRest), etcd and HAProxy/keepalived on vSphere, built with Terraform and 49 Ansible roles to meet national level-3 information security requirements. 54 ADRs and 76 runbooks.
                    </li>
                    <li>
                      Kubernetes migration of the FIDO2 stack (16 VMs) with a staged data-tier move and a cutover runbook.
                    </li>
                    <li>
                      HA customer deployments: active/passive FIDO2 stack with keepalived and HAProxy, CIS Level 2 hardening, RTO of 2 to 5 minutes and RPO of 5 minutes or less, plus offline installers.
                    </li>
                    <li>
                      Observability and security monitoring with Prometheus, Loki, Grafana, Alertmanager and Wazuh, detection-as-code rules, an AIOps pilot that triages alerts with an LLM, and an Ask assistant that answers plain-language questions over logs and metrics through read-only tools, PII redaction and cost caps.
                    </li>
                    <li>
                      Native macOS client for the access mesh (Swift and a Go daemon), in progress.
                    </li>
                    <li>
                      Architecture and deployment documentation for customers' infrastructure teams, in English and Vietnamese.
                    </li>
                  </ul>
                </div>
                <div class="flex flex-wrap gap-1 mt-3 md:justify-end">
                  <span class="badge badge-outline badge-xs">Kubernetes</span>
                  <span class="badge badge-outline badge-xs">ArgoCD</span>
                  <span class="badge badge-outline badge-xs">Istio</span>
                  <span class="badge badge-outline badge-xs">Teleport</span>
                  <span class="badge badge-outline badge-xs">Keycloak</span>
                  <span class="badge badge-outline badge-xs">Terraform</span>
                  <span class="badge badge-outline badge-xs">Ansible</span>
                  <span class="badge badge-outline badge-xs">Patroni</span>
                  <span class="badge badge-outline badge-xs">Prometheus</span>
                  <span class="badge badge-outline badge-xs">Loki</span>
                  <span class="badge badge-outline badge-xs">Grafana</span>
                  <span class="badge badge-outline badge-xs">Wazuh</span>
                </div>
              </div>
              <hr class="bg-primary" />
            </li>

            <%!-- Netacom --%>
            <li>
              <hr class="bg-primary" />
              <div class="timeline-middle">
                <.icon name="hero-check-circle-solid" class="size-6 text-primary" />
              </div>
              <div class="timeline-end mb-10">
                <time class="font-mono text-sm text-primary font-bold">2019 - 2022</time>
                <div class="text-xl font-bold mt-2">Netacom (VPBank subsidiary)</div>
                <div class="text-base-content/70 font-semibold text-lg">DevOps Lead</div>
                <div class="mt-3 text-base-content/60 text-sm space-y-1">
                  <p>
                    Led DevOps for Netacom and built its infrastructure from scratch: Kubernetes environments for dev, staging and production, CI/CD automation, and Kafka, TiDB and MinIO deployments. Supported the chat platform used by VNDirect, a video-on-demand streaming app and the Lomo social networking app.
                  </p>
                </div>
                <div class="flex flex-wrap gap-1 mt-3">
                  <span class="badge badge-outline badge-xs">Kubernetes</span>
                  <span class="badge badge-outline badge-xs">GitLab CI/CD</span>
                  <span class="badge badge-outline badge-xs">Kafka</span>
                  <span class="badge badge-outline badge-xs">TiDB</span>
                  <span class="badge badge-outline badge-xs">MinIO</span>
                </div>
              </div>
              <hr class="bg-primary" />
            </li>

            <%!-- Datamark --%>
            <li>
              <hr class="bg-primary" />
              <div class="timeline-middle">
                <.icon name="hero-check-circle-solid" class="size-6 text-secondary" />
              </div>
              <div class="timeline-start md:text-end mb-10">
                <time class="font-mono text-sm text-secondary font-bold">2018 - 2019</time>
                <div class="text-xl font-bold mt-2">Datamark (UOB)</div>
                <div class="text-base-content/70 font-semibold text-lg">
                  Backend Developer, E-commerce
                </div>
                <div class="mt-3 text-base-content/60 text-sm space-y-1">
                  <p>
                    Worked on e-commerce operations for shops on Shopee. Built data pipelines that collect and process shop data (products, orders, transactions), and worked with UOB on credit-risk assessment dashboards and customer analytics.
                  </p>
                </div>
                <div class="flex flex-wrap gap-1 mt-3 md:justify-end">
                  <span class="badge badge-outline badge-xs">Data pipelines</span>
                  <span class="badge badge-outline badge-xs">Shopee API</span>
                  <span class="badge badge-outline badge-xs">Dashboards</span>
                </div>
              </div>
              <hr />
            </li>

            <%!-- Yeah1 --%>
            <li>
              <hr />
              <div class="timeline-middle">
                <.icon name="hero-check-circle-solid" class="size-6 text-secondary" />
              </div>
              <div class="timeline-end mb-10">
                <time class="font-mono text-sm text-secondary font-bold">2017 - 2018</time>
                <div class="text-xl font-bold mt-2">Yeah1 Group</div>
                <div class="text-base-content/70 font-semibold text-lg">Full-Stack Developer</div>
                <div class="mt-3 text-base-content/60 text-sm space-y-1">
                  <p>
                    Built the internal ERP system in Elixir and Phoenix. Integrated the Facebook and YouTube APIs for content analytics, and built financial reporting tools and Excel-based data systems together with the CFO.
                  </p>
                </div>
                <div class="flex flex-wrap gap-1 mt-3">
                  <span class="badge badge-outline badge-xs">Elixir</span>
                  <span class="badge badge-outline badge-xs">Phoenix</span>
                  <span class="badge badge-outline badge-xs">ERP</span>
                  <span class="badge badge-outline badge-xs">Facebook API</span>
                  <span class="badge badge-outline badge-xs">YouTube API</span>
                </div>
              </div>
              <hr />
            </li>

            <%!-- SSGroup --%>
            <li>
              <hr />
              <div class="timeline-middle">
                <.icon name="hero-check-circle-solid" class="size-6 text-base-content/40" />
              </div>
              <div class="timeline-start md:text-end mb-10">
                <time class="font-mono text-sm text-base-content/50">2014 - 2017</time>
                <div class="text-xl font-bold mt-2">SSGroup / ECDC</div>
                <div class="text-base-content/70 font-semibold text-lg">
                  Division Lead, Web &amp; Mobile
                </div>
                <div class="mt-3 text-base-content/60 text-sm space-y-1">
                  <p>
                    Led the engineering division for all web and mobile products, including Appcent, SSPayment and Samsung Flix TV, covering architecture, development, delivery and team management.
                  </p>
                </div>
                <div class="flex flex-wrap gap-1 mt-3 md:justify-end">
                  <span class="badge badge-outline badge-xs">Architecture</span>
                  <span class="badge badge-outline badge-xs">Team Lead</span>
                  <span class="badge badge-outline badge-xs">Web</span>
                  <span class="badge badge-outline badge-xs">Mobile</span>
                </div>
              </div>
              <hr />
            </li>

            <%!-- VNG --%>
            <li>
              <hr />
              <div class="timeline-middle">
                <.icon name="hero-check-circle-solid" class="size-6 text-base-content/40" />
              </div>
              <div class="timeline-end mb-10">
                <time class="font-mono text-sm text-base-content/50">2006 - 2014</time>
                <div class="text-xl font-bold mt-2">VNG Corporation</div>
                <div class="text-base-content/70 font-semibold text-lg">
                  Web Framework Lead, Game Division
                </div>
                <div class="mt-3 text-base-content/60 text-sm space-y-1">
                  <p>
                    Led the web framework infrastructure for VNG's Game Division for 8 years. Ran core server systems (DNS, Nginx load balancing, SMTP gateway, MySQL clustering) behind games, payment gateways and community platforms with millions of concurrent users.
                  </p>
                </div>
                <div class="flex flex-wrap gap-1 mt-3">
                  <span class="badge badge-outline badge-xs">Linux</span>
                  <span class="badge badge-outline badge-xs">Nginx</span>
                  <span class="badge badge-outline badge-xs">MySQL</span>
                  <span class="badge badge-outline badge-xs">DNS</span>
                </div>
              </div>
            </li>
          </ul>

          <%!-- Summary Stats --%>
          <div class="mt-16 grid grid-cols-2 md:grid-cols-4 gap-4">
            <div class="stat bg-base-200 rounded-box text-center">
              <div class="stat-value text-primary">20</div>
              <div class="stat-desc">Years Experience</div>
            </div>
            <div class="stat bg-base-200 rounded-box text-center">
              <div class="stat-value text-secondary">6</div>
              <div class="stat-desc">Companies</div>
            </div>
            <div class="stat bg-base-200 rounded-box text-center">
              <div class="stat-value text-accent">6+</div>
              <div class="stat-desc">Years Elixir</div>
            </div>
            <div class="stat bg-base-200 rounded-box text-center">
              <div class="stat-value text-info">3+</div>
              <div class="stat-desc">Years K8s/DevOps</div>
            </div>
          </div>

          <%!-- Education --%>
          <div id="education" class="mt-16">
            <h2 class="text-2xl font-bold mb-6 text-center">Education</h2>
            <ul class="grid gap-4 md:grid-cols-2">
              <li id="education-hcmut" class="bg-base-200 rounded-box p-5">
                <time class="font-mono text-sm text-primary font-bold">1998 - 2003</time>
                <div class="text-lg font-bold mt-1">
                  Ho Chi Minh City University of Technology (HCMUT)
                </div>
                <div class="text-base-content/70 text-sm">Bachelor of Engineering program</div>
              </li>
              <li id="education-pmi" class="bg-base-200 rounded-box p-5">
                <time class="font-mono text-sm text-primary font-bold">2010</time>
                <div class="text-lg font-bold mt-1">PMI</div>
                <div class="text-base-content/70 text-sm">
                  Project Management Professional training program
                </div>
              </li>
            </ul>
          </div>

          <div class="mt-16 text-center">
            <a
              href={MqaPortfolio.Content.contact_url()}
              id="experience-contact"
              class="btn btn-primary btn-lg"
            >
              Get in touch <.icon name="hero-arrow-right" class="size-5" />
            </a>
          </div>
        </div>
      </section>
    </Layouts.app>
    """
  end
end
