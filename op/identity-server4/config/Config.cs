// Copyright (c) Brock Allen & Dominick Baier. All rights reserved.
// Licensed under the Apache License, Version 2.0. See LICENSE in the project root for license information.


using IdentityServer4;
using IdentityServer4.Models;
using System.Collections.Generic;

namespace IdentityServer
{
    public static class Config
    {
        public static IEnumerable<IdentityResource> Ids =>
            new List<IdentityResource>
            {
                new IdentityResources.OpenId(),
                new IdentityResources.Profile(),
            };


        public static IEnumerable<ApiResource> Apis =>
            new List<ApiResource>
            {
                new ApiResource("api1", "My API")
            };

        public static IEnumerable<Client> Clients =>
            new List<Client>
            {
                new Client
                {
                    ClientId = "honest-idp",
                    ClientName = "PrOfESSOS Honest Test-Client",
                    // ClientSecrets = { new Secret("secret".Sha256()) },

                    AllowedGrantTypes = GrantTypes.Implicit,
                    // RequireConsent = false,
                    //RequirePkce = true,
                
                    // where to redirect to after login
                    RedirectUris = { "https://rp.professos/identityserver4/callback" },

                    // where to redirect to after logout
                    // PostLogoutRedirectUris = { "http://localhost:5002/signout-callback-oidc" },

                    AllowedScopes = new List<string>
                    {
                        IdentityServerConstants.StandardScopes.OpenId,
                        IdentityServerConstants.StandardScopes.Profile
                    },
                },
                new Client
                    {
                        ClientId = "honest-idp2",
                        ClientName = "PrOfESSOS Honest Test-Client",
                        // ClientSecrets = { new Secret("secret".Sha256()) },

                        AllowedGrantTypes = GrantTypes.Implicit,
                        // RequireConsent = false,
                        //RequirePkce = true,

                        // where to redirect to after login
                        RedirectUris = { "https://rp.professos/identityserver4/callback" },

                        // where to redirect to after logout
                        // PostLogoutRedirectUris = { "http://localhost:5002/signout-callback-oidc" },

                        AllowedScopes = new List<string>
                        {
                            IdentityServerConstants.StandardScopes.OpenId,
                            IdentityServerConstants.StandardScopes.Profile
                        },
                    },
                new Client
                {
                    ClientId = "identityserver4",
                    ClientSecrets = { new Secret("79a42e2d-1bfd-44dd-9a0b-0a7aa762fd5c") },

                    AllowedGrantTypes = GrantTypes.Code,
                    // RequireConsent = false,
                    // RequirePkce = true,

                    // where to redirect to after login
                    RedirectUris = { "https://py-oidcrp/authz_cb/identityserver4" },

                    // where to redirect to after logout
                    PostLogoutRedirectUris = { "https://py-oidcrp/session_logout/identityserver4" },

                    AllowedScopes = new List<string>
                    {
                        IdentityServerConstants.StandardScopes.OpenId,
                        IdentityServerConstants.StandardScopes.Profile
                    },
                }
            };
    }
}
