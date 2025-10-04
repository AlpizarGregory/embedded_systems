#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>

#define PORT "4547"
#define HOST "localhost"

void error(char *msg)
{
    perror(msg);
    exit(0);
}

int main(int argc, char *argv[])
{
    int sockfd, portno, n;
    struct sockaddr_in serv_addr;
    struct hostent *server;

    char buffer[256];

    portno = atoi(PORT);
    sockfd = socket(AF_INET, SOCK_STREAM, 0);

    if (sockfd < 0)
    {
        error("ERROR opening socket");
    }

    server = gethostbyname(HOST);

    if (server == NULL)
    {
        fprintf(stderr, "ERROR no such host\n");
        exit(0);
    }

    bzero((char *) &serv_addr, sizeof(serv_addr));
    serv_addr.sin_family = AF_INET;

    bcopy((char *) server->h_addr, (char *) &serv_addr.sin_addr.s_addr, server->h_length);

    serv_addr.sin_port = htons(portno);

    if (connect(sockfd, &serv_addr, sizeof(serv_addr)) < 0)
    {
        error("ERROR connecting");
    }

    n = write(sockfd, argv[1], strlen(argv[1]));

    if (n < 0)
    {
        error("ERROR writing to socket");
    }

    return 0;
}
