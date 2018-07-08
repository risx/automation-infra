#!/usr/bin/env python3

import boto3
import logging

zoneid = 'Z3BVSIHT2MG7MV'
session = boto3.Session(profile_name='default')

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def GetRoute53():
    r53_ips = {}

    try:
        client = session.client('route53')
        records = client.list_resource_record_sets(HostedZoneId=zoneid)
    except:
        logging.warn('An error occured with connecting to your AWS route53')
        logging.warn(sys.exc_info()[0])
    
    # if (records['isTruncated']):
    #     print(records['NextRecordName'])

    logger.info('Obtaining Route53 Information.')
    for record in records['ResourceRecordSets']:
        logging.info(record)

    return r53_ips


def main():
    GetRoute53()

if __name__ == '__main__':
    main()